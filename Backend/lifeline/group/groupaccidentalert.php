<?php
  require __DIR__ . '/twiliostuff/vendor/autoload.php';
  use Twilio\Rest\Client;
  include 'twiliodata.php';

  include 'databaseinfo.php';
  $conn = new mysqli($servername, $username, $password, $dbname);
  if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
  }

  $records = array();
  $records['phone'] = $_POST['phone'];

  $sql = "SELECT * FROM member WHERE phone='".$records['phone']."'";
  $result = $conn->query($sql);

  if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
	  $records['result'] = "No group members";
	  $records['name'] = $row['member_name'];
	  $records['latitude'] = $row['latitude'];
	  $records['longitude'] = $row['longitude'];
	  $records['when'] = $row['timing'];
    }
  } else {
    $records['result'] = "No such member";
	$conn->close();
	header('Content-Type: application/json');
	echo json_encode($records, JSON_PRETTY_PRINT);
	return;
  }

  $sql = "SELECT DISTINCT member_phone
		  FROM family_member
		  WHERE member_phone!=".$records['phone']." AND family_id IN
		  (SELECT family_id
		  FROM family_member
		  WHERE member_phone=".$records['phone'].");";

  $result = $conn->query($sql);

  $message = "LifeLine\nUser ".$records['name'].", phone number ".$records['phone'].",
			has gotten into an accident, last seen at ".$records['when'].", at latitude ".$records['latitude']."
			and longitude ".$records['longitude'].".";

  if ($result->num_rows > 0) {
	$records['result'] = "success";
    while($row = $result->fetch_assoc()) {
	  $client = new Client($account_sid, $auth_token);
	  $client->messages->create(
	    $row['member_phone'],
	     array(
		  'from' => $twilio_number,
		  'body' => $message
	    )
	  );
    }
  }
  $conn->close();

  header('Content-Type: application/json');
  echo json_encode($records, JSON_PRETTY_PRINT);
?>
