<?php
  include 'databaseinfo.php';
  
  $group = $_POST['group_id'];

  $conn = new mysqli($servername, $username, $password, $dbname);
  if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
  }

  $sql = "SELECT phone, member_name as name, role, profile_picture as picture, latitude, longitude, timing as 'when'
		  FROM member
		  INNER JOIN family_member
		  ON family_member.member_phone=member.phone
		  WHERE family_member.family_id='".$group."'";
  
  $result = $conn->query($sql);
  $size = $result->num_rows;
  $records = array();

  if ($size > 0) {
	$records['result'] = "success";
	$records['size'] = $size;
    while($row = $result->fetch_assoc()) {
      $records[] = $row;
    }
  } else {
    $records['result'] = "No group members";
  }
  $conn->close();
  header('Content-Type: application/json');
  echo json_encode($records, JSON_PRETTY_PRINT);
?>