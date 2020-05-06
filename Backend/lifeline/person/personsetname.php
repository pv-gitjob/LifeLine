<?php
  include 'databaseinfo.php';
  $phone = $_POST['phone'];
  $name = $_POST['name'];

  $conn = new mysqli($servername, $username, $password, $dbname);
  if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
  }

  $sql = "SELECT * FROM member WHERE phone='" .$phone. "'";
  $result = $conn->query($sql);
  $records = array();
  
  if ($result->num_rows > 0) {
    $sql = "UPDATE member SET member_name='" .$name. "' WHERE phone='" .$phone. "'";
    if ($conn->query($sql) === TRUE) {
		
      $records['result'] = "success";
	  while($row = $result->fetch_assoc()) {
     	$records['phone'] = $phone;
		$records['name'] = $name;
	    $records['picture'] = $row['profile_picture'];  
	  }
	  
    } else {
      $records['result'] = "Unable to change name";
    }
  } else {
    $records['result'] = "No such user";
  }

  $conn->close();
  header('Content-Type: application/json');
  echo json_encode($records, JSON_PRETTY_PRINT);
?>