<?php
  include 'databaseinfo.php';

  $group_id = $_POST['group_id'];

  $conn = new mysqli($servername, $username, $password, $dbname);
  if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
  }

  $sql = "SELECT * FROM family WHERE family_id='" .$group_id. "'";
  $result = $conn->query($sql);
  $records = array();

  if ($result->num_rows > 0) {
	$records['result'] = "success";
    while($row = $result->fetch_assoc()) {
      $records[] = $row;
    }
  } else {
    $records['result'] = "No such group";
  }

  $conn->close();
  header('Content-Type: application/json');
  echo json_encode($records, JSON_PRETTY_PRINT);
?>