// To parse this JSON data, do
//
//     final shipper = shipperFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

List<Shipper> shipperFromJson(String str) => List<Shipper>.from(json.decode(str).map((x) => Shipper.fromJson(x)));

String shipperToJson(List<Shipper> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Shipper with ChangeNotifier {
  Shipper({
    this.mashipper,
    this.ten,
    this.ngaySinh,
    this.diachi,
    this.sdt,
    this.hinhanh,
    this.matkhau,
  });

  String mashipper;
  String ten;
  DateTime ngaySinh;
  String diachi;
  String sdt;
  dynamic hinhanh;
  String matkhau;

  factory Shipper.fromJson(Map<String, dynamic> json) => Shipper(
    mashipper: json["Mashipper"],
    ten: json["Ten"],
    ngaySinh: DateTime.parse(json["NgaySinh"]),
    diachi: json["Diachi"],
    sdt: json["Sdt"],
    hinhanh: json["Hinhanh"],
    matkhau: json["Matkhau"],
  );

  Map<String, dynamic> toJson() => {
    "Mashipper": mashipper,
    "Ten": ten,
    "NgaySinh": "${ngaySinh.year.toString().padLeft(4, '0')}-${ngaySinh.month.toString().padLeft(2, '0')}-${ngaySinh.day.toString().padLeft(2, '0')}",
    "Diachi": diachi,
    "Sdt": sdt,
    "Hinhanh": hinhanh,
    "Matkhau": matkhau,
  };
}
