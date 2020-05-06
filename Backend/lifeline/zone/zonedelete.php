<?php
  include 'databaseinfo.php';

  $family_id = $_POST['group_id'];
  $admin_phone = $_POST['admin'];
  $member_phone = $_POST['phone'];
  $latitude = $_POST['latitude'];
  $longitude = $_POST['longitude'];
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
	    $records['result'] = "Need to be an admin to delete zones";
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

  $sql = "DELETE FROM map_zone WHERE family_id=" .$family_id. " AND member_phone='" 
		.$member_phone. "' AND latitude='" .$latitude. "' AND longitude='" .$longitude. "'";
  if ($conn->query($sql) === TRUE) {
    $records['result'] = "success";
  } else {
    $records['result'] = "Unable to delete zone";
  }

  $conn->close();
  header('Content-Type: application/json');
  echo json_encode($records, JSON_PRETTY_PRINT);
?>