<?php
  include 'databaseinfo.php';

  $family_id = $_POST['group_id'];
  $admin_phone = $_POST['admin'];
  $member_phone = $_POST['phone'];
  $latitude = $_POST['latitude'];
  $longitude = $_POST['longitude'];
  $radius = $_POST['radius'];
  $safe = $_POST['safe'];
  $timing_start = $_POST['timing_start'];
  $timing_end = $_POST['timing_end'];
  $name = $_POST['name'];
  $records = array();

  $conn = new mysqli($servername, $username, $password, $dbname);
  if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
  }

  if ($safe != 1 and $safe != 0) {
    $safe = 1;
  }
  
  $sql = "SELECT * FROM family_member WHERE family_id='" .$family_id. "' AND member_phone='" .$admin_phone. "'";
  $result = $conn->query($sql);
  if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
      if($row['role'] != "adm") {
	    $records['result'] = "Need to be an admin to add zones";
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

  $sql = "INSERT INTO map_zone VALUES ('" .$family_id. "','" .$member_phone. "','" .$latitude. "','" .$longitude. "','" .$timing_start. "','" .$timing_end. "','" .$radius. "','" .$safe. "','" .$name."')";
  if ($conn->query($sql) === TRUE) {
    $records['result'] = "success";
  } else {
    $records['result'] = "Unable to create zone";
  }

  $conn->close();
  header('Content-Type: application/json');
  echo json_encode($records, JSON_PRETTY_PRINT);
?>