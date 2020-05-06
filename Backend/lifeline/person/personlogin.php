<?php
  include 'databaseinfo.php';
  $phone = $_POST['phone'];
  $acc_pass = $_POST['acc_pass'];

  $conn = new mysqli($servername, $username, $password, $dbname);
  if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
  }

  $sql = "SELECT * FROM member WHERE phone='" .$phone. "'";
  $result = $conn->query($sql);
  $records = array();
  
  if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
      if(password_verify($acc_pass, $row["acc_pass"])) {
		$records['result'] = "success";  
        $records['phone'] = $row['phone'];
	    $records['name'] = $row['member_name'];
 	    $records['picture'] = $row['profile_picture'];
      } else {
        $records['result'] = "Unable to login";
      }
    }
  } else {
    $records['result'] = "No such user";
  }

  $conn->close();
  header('Content-Type: application/json');
  echo json_encode($records, JSON_PRETTY_PRINT);
?>