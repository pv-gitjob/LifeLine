<?php
  include 'databaseinfo.php';

  $phone = $_POST['phone'];

  $conn = new mysqli($servername, $username, $password, $dbname);
  if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
  }

  $sql = "SELECT family.family_id as group_id, family.family_name as group_name, family.profile_picture as picture, family.owner_phone as is_owner, family_member.role as role
          FROM family
          INNER JOIN family_member
          ON family.family_id=family_member.family_id
          WHERE family_member.member_phone='" .$phone. "'";

  $result = $conn->query($sql);
  $size = $result->num_rows;
  $records = array();

  if ($size > 0) {
	$records['result'] = "success";
	$records['size'] = $size;
    while($row = $result->fetch_assoc()) {
	  if ($row["is_owner"] != $phone) {
	    $row["is_owner"] = false;
	  } else {
		$row["is_owner"] = true;
	  }
	  $records[] = $row;
    }
  } else {
    $records['result'] = "No groups";
  }
  
  $conn->close();
  header('Content-Type: application/json');
  echo json_encode($records, JSON_PRETTY_PRINT);
?>