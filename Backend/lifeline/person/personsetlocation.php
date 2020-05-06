<?php
  include 'databaseinfo.php';
  $phone = $_POST['phone'];
  $latitude = $_POST['latitude'];
  $longitude = $_POST['longitude'];
  $when = $_POST['when'];

  $conn = new mysqli($servername, $username, $password, $dbname);
  if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
  }

  $sql = "SELECT * FROM member WHERE phone='" .$phone. "'";
  $result = $conn->query($sql);
  $records = array();
  
  if ($result->num_rows > 0) {
    $sql = "UPDATE member 
			SET latitude='".$latitude."', longitude='".$longitude."', timing='".$when."'
			WHERE phone='" .$phone. "'";
    if ($conn->query($sql) === TRUE) {	
      $records['result'] = "success";
    } else {
      $records['result'] = "Unable to update location";
    }
  } else {
    $records['result'] = "No such user";
  }

  $conn->close();
  header('Content-Type: application/json');
  echo json_encode($records, JSON_PRETTY_PRINT);
?>