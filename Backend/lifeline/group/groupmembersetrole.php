<?php
  include 'databaseinfo.php';
  $phone = $_POST['phone'];
  $admin_phone = $_POST['admin_phone'];
  $name = $_POST['name'];
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
	    $records['result'] = "Need to be administrator to set roles";
		$conn->close();
		exit();
	  }
    }
  } else {
    $records['result'] = "No such group or member";
	$conn->close();
	exit();
  }

  $sql = "SELECT * FROM member WHERE phone='" .$phone. "'";
  $result = $conn->query($sql);
  if ($result->num_rows > 0) {
    $sql = "UPDATE member SET member_name='" .$name. "' WHERE phone='" .$phone. "'";
    if ($conn->query($sql) === TRUE) {
      $records['result'] = "success";
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