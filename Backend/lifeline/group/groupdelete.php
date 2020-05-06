<?php
  include 'databaseinfo.php';

  $group_id = $_POST['group_id'];
  $owner_phone = $_POST['owner_phone'];
  $records = array();

  $conn = new mysqli($servername, $username, $password, $dbname);
  if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
  }

  $sql = "SELECT owner_phone FROM family WHERE family_id='" .$group_id. "'";
  $result = $conn->query($sql);
  if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
      if($row["owner_phone"] != $owner_phone) {
	    $records['result'] = "Need to be owner to delete group";
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

  $sql = "DELETE FROM family WHERE family_id='" .$group_id. "'";
  if ($conn->query($sql) === TRUE) {
    $records['result'] = "success";
  } else {
    $records['result'] = "Unable to delete group";
  }
  $conn->close();
  header('Content-Type: application/json');
  echo json_encode($records, JSON_PRETTY_PRINT);
?>