<?php
	$host = "localhost";
	$username = "root";
	$password ="";
	$database = "food";

	$conn = mysqli_connect($host,$username,$password,$database);
	mysqli_query($conn,"SET NAME 'ut8'");
	if ($conn) {
	}else{
	echo "ket noi ko thanh cong";
	}
?>