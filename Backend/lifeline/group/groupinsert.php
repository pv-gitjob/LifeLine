<?php
  include 'databaseinfo.php';

  $name = $_POST['name'];
  $owner = $_POST['phone'];
  $records = array();

  $conn = new mysqli($servername, $username, $password, $dbname);
  if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
  }

  $group_id = -1;

  $sql = "INSERT INTO family (family_name, owner_phone) VALUES ('" .$name. "','" .$owner. "')";
  if ($conn->query($sql) === TRUE) {
    $records['result'] = "success";
    $group_id = $conn->insert_id;
	
	$sql = "INSERT INTO family_member VALUES ('" .$group_id. "','" .$owner. "','adm')";
	if ($conn->query($sql) === FALSE) {
      $sql = "DELETE FROM family WHERE family_id='" .$group_id. "'";
      $conn->query($sql);
      $records['result'] = "Unable to create group";
    } else {
	  $records['group_id'] = $group_id;
	}
	
  } else {
    $records['result'] = "Unable to create group";
  }

  $conn->close();
  header('Content-Type: application/json');
  echo json_encode($records, JSON_PRETTY_PRINT);
?>