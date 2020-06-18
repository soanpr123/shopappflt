<?php
	//cái này dùng để làm menu
	include "connect.php";
	$query = "SELECT * FROM tblttshipper";
	$data = mysqli_query($conn,$query);
	$mangsipper  = array();
	while ($row = mysqli_fetch_assoc($data)) {
		array_push($mangsipper, new Shipper(
			$row['Mashipper'],
			$row['Ten'],
			$row['Ngaysinh'],
			$row['Diachi'],
			$row['Sdt'],
			$row['Hinhanh'],
			$row['Gioitinh'],
			$row['Matkhau'],
		
		));
	}
	echo json_encode($mangsipper);
	class Shipper{
		function Shipper($Mashipper,$Ten,$Ngaysinh,$Diachi,$Sdt,$Hinhanh,$Gioitinh,$Matkhau){
			$this->Mashipper = $Mashipper;
			$this->Ten = $Ten;
			$this->NgaySinh = $Ngaysinh;
			$this->Diachi = $Diachi;
			$this->Sdt = $Sdt;
			$this->Hinhanh = $Hinhanh;
			$this->Matkhau = $Matkhau;
		}
	}
?>