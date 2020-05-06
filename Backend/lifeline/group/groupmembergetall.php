<?php
  include 'databaseinfo.php';

  $conn = new mysqli($servername, $username, $password, $dbname);
  if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
  }

  $sql = "SELECT * FROM family_member";
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