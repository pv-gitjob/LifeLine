<?php
  include 'databaseinfo.php';
  $phone = $_POST['phone'];
  $old_pass = $_POST['old_pass'];
  $new_pass = $_POST['new_pass'];
  $hashed_password = password_hash($new_pass, PASSWORD_DEFAULT);

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
          $records['phone'] = $phone;
	      $records['name'] = $row['member_name'];
	      $records['picture'] = $row['profile_picture'];
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