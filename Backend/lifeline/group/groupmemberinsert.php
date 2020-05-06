<?php
  include 'databaseinfo.php';

  $group_id = $_POST['group_id'];
  $admin_phone = $_POST['admin_phone'];
  $phone = $_POST['phone'];
  $role = $_POST['role'];
  $records = array();
  
  $conn = new mysqli($servername, $username, $password, $dbname);
  if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
  }

  $sql = "SELECT * FROM family_member WHERE family_id='" .$group_id. "' AND member_phone='" .$admin_phone. "'";
  $result = $conn->query($sql);
  if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
      if($row['role'] != "adm") {
	    $records['result'] = "Need to be administrator to add members";
	  } else {
		$sql = "INSERT INTO family_member VALUES (" .$group_id. ",'" .$phone. "','" .$role. "')";
        if ($conn->query($sql) === TRUE) {
          $records['result'] = "success";
        } else {
	      $records['result'] = "Unable to add member";
        }    
	  }
    }
  } else {
    $records['result'] = "No such group or member";
  }

  $conn->close();
  header('Content-Type: application/json');
  echo json_encode($records, JSON_PRETTY_PRINT);
?>