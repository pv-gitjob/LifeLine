<?php
  include 'databaseinfo.php';

  $name = $_POST['name'];
  $phone = $_POST['phone'];
  $acc_pass = $_POST['acc_pass'];
  $hashed_password = password_hash($acc_pass, PASSWORD_DEFAULT);
  $picture = "http://praveenv.org/lifeline/person/profpics/defaultpic.png";
  $records = array();
  
  $conn = new mysqli($servername, $username, $password, $dbname);
  if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
  }

  $sql = "SELECT * FROM member WHERE phone='" .$phone. "'";
  $result = $conn->query($sql);
  if ($result->num_rows > 0) {
	$records['result'] = "User exists";
  } else {
	$sql = "INSERT INTO member (phone, member_name, acc_pass)
			VALUES ('" .$phone. "','" .$name. "','" .$hashed_password. "')";
	if ($conn->query($sql) === TRUE) {
	  $records['result'] = "success";
	  $records['phone'] = $phone;
	  $records['name'] = $name;
      $records['picture'] = $picture;
	} else {
      $records['result'] = "Unable create user" . $conn->error;
	}  
  }

  $conn->close();
  header('Content-Type: application/json');
  echo json_encode($records, JSON_PRETTY_PRINT);
?>