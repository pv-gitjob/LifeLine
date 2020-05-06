<?php
  include 'databaseinfo.php';

  $group_id = $_POST['group_id'];
  $admin_phone = $_POST['admin_phone'];
  $phone = $_POST['phone'];
  $records = array();

  $conn = new mysqli($servername, $username, $password, $dbname);
  if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
  }

  $sql = "SELECT * FROM family WHERE family_id='" .$group_id. "'";
  $result = $conn->query($sql);
  if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
      if($row['owner_phone'] == $phone) {
	    $records['result'] = "Cannot delete owner";
		$conn->close();
        header('Content-Type: application/json');
	    echo json_encode($records, JSON_PRETTY_PRINT);
		exit();
	  }
    }
  } else {
    $records['result'] = "No such group";
	$conn->close();
	header('Content-Type: application/json');
    echo json_encode($records, JSON_PRETTY_PRINT);
	exit();
  }

  $sql = "SELECT * FROM family_member WHERE family_id='" .$group_id. "' AND member_phone='" .$admin_phone. "'";
  $result = $conn->query($sql);
  if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
      if($row['role'] != "adm") {
	    $records['result'] = "Need to be administrator to delete members";
		$conn->close();
		header('Content-Type: application/json');
		echo json_encode($records, JSON_PRETTY_PRINT);
		exit();
	  }
    }
  } else {
    $records['result'] = "No such member";
	$conn->close();
	header('Content-Type: application/json');
	echo json_encode($records, JSON_PRETTY_PRINT);
	exit();
  }

  $sql = "DELETE FROM family_member WHERE family_id='" .$group_id. "' AND member_phone='" .$phone. "'";
  if ($conn->query($sql) === TRUE) {
    $records['result'] = "success";
  } else {
    $records['result'] = "Unable to delete group member";
  }
  
  $conn->close();
  header('Content-Type: application/json');
  echo json_encode($records, JSON_PRETTY_PRINT);
?>