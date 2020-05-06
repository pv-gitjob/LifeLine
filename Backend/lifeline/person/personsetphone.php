<?php
  include 'databaseinfo.php';
  $old_phone = $_POST['old_phone'];
  $new_phone = $_POST['new_phone'];
  $acc_pass = $_POST['acc_pass'];
  $url = "http://ec2-54-241-187-187.us-west-1.compute.amazonaws.com/lifeline/person/";
  $dir = "profpics/";

  $conn = new mysqli($servername, $username, $password, $dbname);
  if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
  }

  $sql = "SELECT * FROM member WHERE phone='" .$old_phone. "'";
  $result = $conn->query($sql);
  $records = array();

  if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
      if(password_verify($acc_pass, $row["acc_pass"])) {
        $sql = "UPDATE member SET phone='" .$new_phone. "' WHERE phone='" .$old_phone. "'";
        if ($conn->query($sql) === TRUE) {
          
		  $records['result'] = "success";

		  if ($result["profile_picture"] != $url.$dir."defaultpic.png") {
			rename($dir.$old_phone.".png", $dir.$new_phone.".png");
			$sql = "UPDATE member SET profile_picture='" .$url.$dir.$new_phone. ".png' WHERE phone='" .$new_phone. "'";
			$conn->query($sql);
		  }
		  $records['phone'] = $new_phone;
	      $records['name'] = $row['member_name'];
		  $records['picture'] = $row['profile_picture'];
		
        } else {
          $records['result'] = "Unable to change phone number";
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