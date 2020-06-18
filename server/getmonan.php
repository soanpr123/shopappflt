<?php
	//cái này sau khi có quán rồi thì nhấp vào sẽ thấy các món ăn trong quán đấy 
	include "connect.php";
	$rawData =file_get_contents('php://input');
	$test = json_decode($rawData);
	
	$Mquan = isset($test->Maquan) ? $test->Maquan : null; //chỗ này khi code em xoa số 1 và thay thế bằng $_POST['Maquan']
	$mangmonan = array();
	$query = "SELECT * FROM tblMonan WHERE Maquan = $Mquan";
	$data = mysqli_query($conn,$query);
	while ($row = mysqli_fetch_assoc($data)) {
		array_push($mangmonan, new Monan(
			$row['Mamonan'],
			$row['Maquan'],
			$row['Hinhanh'],
			$row['Giatien'],
			$row['Mota']));
	}
	echo json_encode($mangmonan);
	class Monan{
		function Monan($Mamonan,$Maquan,$Hinhanh,$Giatien,$Mota){
			$this->Mamonan = $Mamonan;
			$this->Maquan = $Maquan;
			$this->Hinhanh = $Hinhanh;
			$this->Giatien = $Giatien;
			$this->Mota = $Mota;
		}
	}
?>