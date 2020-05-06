<?php
  include 'databaseinfo.php';
  $conn = new mysqli($servername, $username, $password, $dbname);
  if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
  }
	  
  $phone = $_POST['phone'];
  $dir = "profpics/";
  $target_file = $dir . $phone . ".png";
  $file_name = basename($_FILES["fileToUpload"]["name"], ".".$imageFileType);
  $picture = "http://praveenv.org/lifeline/person/profpics/defaultpic.png";
  $records = array();
  
  $sql = "SELECT * FROM member WHERE phone='" .$phone. "'";
  $result = $conn->query($sql);
  if ($result->num_rows > 0) {
    if (file_exists($target_file)) {
	  if (unlink($target_file)) {
	    $sql = "UPDATE member SET profile_picture='" .$picture. "' WHERE phone='" .$phone. "'";
	    if ($conn->query($sql) === TRUE) {
		  
		  $records['result'] = "success";
		  while($row = $result->fetch_assoc()) {
			$records['phone'] = $phone;
	        $records['name'] = $row['member_name'];
		    $records['picture'] = $picture;  
		  }
	    
		} else {
		  $records['result'] = "Profile picture not updated.";
	    }
	  } else {
	    $records['result'] = "Error deleting picture.";
	  }
	} else {
	  $records['result'] = "No picture to delete.";
	}
  } else {
	$records['result'] = "User does not exist.";
  }

  $conn->close();
  header('Content-Type: application/json');
  echo json_encode($records, JSON_PRETTY_PRINT);
?>