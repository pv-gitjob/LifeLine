<?php
  include 'databaseinfo.php';
  $group = $_POST['group_id'];
  $owner_phone = $_POST['owner_phone'];
  $name = $_POST['name'];
  $records = array();

  $conn = new mysqli($servername, $username, $password, $dbname);
  if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
  }

  $sql = "SELECT owner_phone FROM family WHERE family_id='" .$group. "'";
  $result = $conn->query($sql);
  if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
      if($row["owner_phone"] != $owner_phone) {
	    $records['result'] = "Need to be owner to change group name";
		$conn->close();
		header('Content-Type: application/json');
		echo json_encode($records, JSON_PRETTY_PRINT);
		exit();
	  }
    }
  } else {
    $records['result'] = "No such family";
	$conn->close();
	header('Content-Type: application/json');
	echo json_encode($records, JSON_PRETTY_PRINT);
	exit();
  }

  $sql = "UPDATE family SET family_name='" .$name. "' WHERE family_id='" .$group. "'";
  if ($conn->query($sql) === TRUE) {
    $records['result'] = "success";
  } else {
    $records['result'] = "Unable to change group name";
  }

  $conn->close();
  header('Content-Type: application/json');
  echo json_encode($records, JSON_PRETTY_PRINT);
?>