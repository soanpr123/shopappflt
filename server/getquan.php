<?php

	include "connect.php";
	$rawData =file_get_contents('php://input');
	$test = json_decode($rawData);
	$Lquan = isset($test->loaiquan) ? $test->loaiquan : null; 
	$mangquan = array();
	$query = "SELECT * FROM tblQuan WHERE Loaiquan = $Lquan";
	$data = mysqli_query($conn,$query);
	while ($row = mysqli_fetch_assoc($data)) {
		array_push($mangquan, new Quan(
			$row['Maquan'],
			$row['Tenquan'],
			$row['Diachi'],
			$row['Hinhanh'],
			$row['Thoigianhoatdong'],
			$row['Trangthai'],
			$row['Matkhau'],
			$row['Loaiquan'],
			$row['Bluan']));
	}
	echo json_encode($mangquan);
	class Quan{
		function Quan($Maquan,$Tenquan,$Diachi,$Hinhanh,$Thoigianhoatdong,$Trangthai,$Matkhau,$Loaiquan,$Bluan){
			$this->Maquan = $Maquan;
			$this->Tenquan = $Tenquan;
			$this->Diachi = $Diachi;
			$this->Hinhanh = $Hinhanh;
			$this->Thoigianhoatdong = $Thoigianhoatdong;
			$this->Trangthai = $Trangthai;
			$this->Matkhau = $Matkhau;
			$this->Loaiquan = $Loaiquan;
			$this->Bluan = $Bluan;
		}
	}
?>