<?php
  require __DIR__ . '/twiliostuff/vendor/autoload.php';
  use Twilio\Rest\Client;
  include 'twiliodata.php';

  $phone = $_POST['phone'];

  $permitted_chars = '0123456789abcdefghijklmnopqrstuvwxyz';
  function generate_string($input, $strength = 16) {
    $input_length = strlen($input);
    $random_string = '';
    for($i = 0; $i < $strength; $i++) {
      $random_character = $input[mt_rand(0, $input_length - 1)];
      $random_string .= $random_character;
    }
    return $random_string;
  }

  $new_pass = generate_string($permitted_chars, 8);
  $message = "LifeLine\nYour new password is ".$new_pass;
  $hashed_password = password_hash($new_pass, PASSWORD_DEFAULT);

  include 'databaseinfo.php';
  $conn = new mysqli($servername, $username, $password, $dbname);
  if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
  }

  $sql = "SELECT * FROM member WHERE phone='" .$phone. "'";
  $result = $conn->query($sql);
  $records = array();

  if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
      if(password_verify($old_pass, $row["acc_pass"])) {
        $sql = "UPDATE member SET acc_pass='" .$hashed_password. "' WHERE phone='".$phone."'";
        if ($conn->query($sql) === TRUE) {
		  $records['result'] = "success";
		  $client = new Client($account_sid, $auth_token);
		  $client->messages->create(
		    $phone,
		    array(
			  'from' => $twilio_number,
			  'body' => $message
		    )
		  );
        } else {
          $records['result'] = "Unable to change password";
        }
      } else {
        $records['result'] = "Wrong password";
      }
    }
  } else {
    $records['result'] = "No such user";
  }
  $conn->close();

  header('Content-Type: application/json');
  echo json_encode($records, JSON_PRETTY_PRINT);
?>
