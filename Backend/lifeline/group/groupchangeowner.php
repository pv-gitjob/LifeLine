<?php
  include 'databaseinfo.php';
  $group = $_POST['group_id'];
  $old_phone = $_POST['old_owner'];
  $new_phone = $_POST['new_owner'];
  $records = array();

  $conn = new mysqli($servername, $username, $password, $dbname);
  if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
  }

  $sql = "SELECT owner_phone FROM family WHERE family_id='" .$group. "'";
  $result = $conn->query($sql);
  if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
      if($row["owner_phone"] != $old_phone) {
	    $records['result'] = "Need to be owner to change owner";
		$conn->close();
		exit();
	  }
    }
  } else {
    $records['result'] = "No such family";
	$conn->close();
	exit();
  }

  $sql = "UPDATE family SET owner_phone='" .$new_phone. "' WHERE family_id='" .$group. "'";
  if ($conn->query($sql) === TRUE) {
	
	$sql = "UPDATE family_member SET role='adm' WHERE family_id='" .$group. "' AND member_phone='" .$new_phone. "'";
    if ($conn->query($sql) === TRUE) {
      $records['result'] = "success";
    } else {
	  $sql = "UPDATE family SET owner_phone='" .$old_phone. "' WHERE family_id='" .$group. "'";
	  $conn->query($sql);
      $records['result'] = "Unable to change group owner";
    }
  
  } else {
    $records['result'] = "Unable to change group owner";
  }

  $conn->close();
  header('Content-Type: application/json');
  echo json_encode($records, JSON_PRETTY_PRINT);
?>