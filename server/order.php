<?php
include "connect.php";
$rawData =file_get_contents('php://input');
$test = json_decode($rawData);  
$Mquan = isset($test->Maquan) ? $test->Maquan : null; 
$Makh = isset($test->Makh) ? $test->Makh : null; 
$Soluong = isset($test->Soluong) ? $test->Soluong : null; 
$MaShipper = isset($test->Mashipper) ? $test->Mashipper : null; 
$Tongtien = isset($test->Tongtien) ? $test->Tongtien : null; 
$Hinhthuctt = isset($test->Hinhthuctt) ? $test->Hinhthuctt : null;
$Tgdat = isset($test->Tgdat) ? $test->Tgdat : null;
$Tggiao = isset($test->Tggiao) ? $test->Tggiao : null;
$Phiship = isset($test->Phiship) ? $test->Phiship : null;

$query="INSERT INTO tbldonhangg(Madh,Maquan,Makh,Soluong,Mashipper,Tongtien,Hinhthuctt,Tgdat,Tggiao,Phiship) VALUES(
    null,'$Mquan','$Makh','$Soluong','$MaShipper','$Tongtien','$Hinhthuctt','$Tgdat','$Tggiao','$Phiship')";
    if(mysqli_query($conn,$query)){
    
        echo 'ok';
    }else{
        echo 'faild';
    }
?>