<?php
  include 'databaseinfo.php';

  $conn = new mysqli($servername, $username, $password, $dbname);
  if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
  }

  $sql = "SELECT * FROM map_zone";
  $result = $conn->query($sql);
  $size = $result->num_rows;
  $records = array();

  if ($size > 0) {
	$records['result'] = "success";
	$records['size'] = $size;
    while($row = $result->fetch_assoc()) {
      $temp = array();
	  $temp['group_id'] = $row['family_id'];
      $temp['member_phone'] = $row['member_phone'];
	  $temp['latitude'] = doubleval($row['latitude']);
	  $temp['longitude'] = doubleval($row['longitude']);
	  $temp['timing_start'] = $row['timing_start'];
	  $temp['timing_end'] = $row['timing_end'];
	  $temp['radius'] = doubleval($row['radius']);
	  $temp['safe'] = boolval($row['safe']);
	  $temp['name'] = $row['zone_name'];
      $records[] = $temp;
    }
  } else {
    $records['result'] = "No zones";
  }
  
  $conn->close();
  header('Content-Type: application/json');
  echo json_encode($records, JSON_PRETTY_PRINT);
?>