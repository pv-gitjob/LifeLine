<?php
  include 'databaseinfo.php';

  $group_id = $_POST['group_id'];
  $phone = $_POST['phone'];
  $records = array();

  $conn = new mysqli($servername, $username, $password, $dbname);
  if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
  }

  $sql = "DELETE FROM family_member WHERE family_id='" .$group_id. "' AND member_phone='" .$phone. "'";
  if ($conn->query($sql) === TRUE) {
    $records['result'] = "success";
  } else {
    $records['result'] = "Unable to delete group member";
  }
  
  $conn->close();
  header('Content-Type: application/json');
  echo json_encode($records, JSON_PRETTY_PRINT);
?>