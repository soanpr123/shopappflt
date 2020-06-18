<?php
	//cái này dùng để làm menu
	include "connect.php";
	$query = "SELECT * FROM tblLoaiquan";
	$data = mysqli_query($conn,$query);
	$mangloaiquan = array();
	while ($row = mysqli_fetch_assoc($data)) {
		array_push($mangloaiquan, new Loaiquan(
			$row['Maloaiquan'],
			$row['Tenloaiquan'],
			$row['hinhanh']));
	}
	echo json_encode($mangloaiquan);
	class Loaiquan{
		function Loaiquan($Maloaiquan,$Tenloaiquan,$hinhanh){
			$this->Maloaiquan = $Maloaiquan;
			$this->Tenloaiquan = $Tenloaiquan;
			$this->hinhanh = $hinhanh;
		}
	}
?>