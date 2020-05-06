<?php
  include 'databaseinfo.php';
  $conn = new mysqli($servername, $username, $password, $dbname);
  if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
  }
	  
  $group_id = $_POST['group_id'];
  $url = "http://praveenv.org/lifeline/group/";
  $dir = "profpics/";
  $target_file = $dir . basename($_FILES["fileToUpload"]["name"]);
  $imageFileType = strtolower(pathinfo($target_file,PATHINFO_EXTENSION));
  $target_file = $dir . $group_id . ".png";
  $file_name = basename($_FILES["fileToUpload"]["name"], ".".$imageFileType);
  $records = array();

  if(isset($_POST["submit"])) {
    $check = getimagesize($_FILES["fileToUpload"]["tmp_name"]);
    if($check == false) {
        $records['result'] = "File is not an image.";
    } else {
	  if ($_FILES["fileToUpload"]["size"] > 5000000) {
        $records['result'] = "Sorry, your file is too large.";
      } else {
		if($imageFileType != "jpg" && $imageFileType != "png" && $imageFileType != "jpeg") {
          $records['result'] = "Sorry, only JPG, JPEG & PNG files are allowed.";
        } else {
		  $sql = "SELECT * FROM family WHERE family_id='" .$group_id. "'";
		  $result = $conn->query($sql);
		  if ($result->num_rows > 0) {	
		    if (move_uploaded_file($_FILES["fileToUpload"]["tmp_name"], $target_file)) {
		      $sql = "UPDATE family SET profile_picture='" .$url.$target_file. "' WHERE family_id='" .$group_id. "'";
			  if ($conn->query($sql) === TRUE) {
				$records['result'] = "success";
				while($row = $result->fetch_assoc()) {
				  $records['group_id'] = $group_id;
				  $records['picture'] = $url.$target_file;  
				}
			  } else {
			    $records['result'] = "Profile picture not updated.";
			  }
			} else {
			  $records['result'] = "Error uploading picture.";
			}
		  } else {
			$records['result'] = "Group does not exist.";
		  }
		}
	  }
	}
  }

  $conn->close();
  header('Content-Type: application/json');
  echo json_encode($records, JSON_PRETTY_PRINT);
?>