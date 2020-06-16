// To parse this JSON data, do
//
//     final tenQuanMd = tenQuanMdFromJson(jsonString);

import 'dart:convert';

List<TenQuanMd> tenQuanMdFromJson(String str) =>
    List<TenQuanMd>.from(json.decode(str).map((x) => TenQuanMd.fromJson(x)));

String tenQuanMdToJson(List<TenQuanMd> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TenQuanMd {
  TenQuanMd({
    this.maquan,
    this.tenquan,
    this.diachi,
    this.hinhanh,
    this.thoigianhoatdong,
    this.trangthai,
    this.matkhau,
    this.loaiquan,
    this.bluan,
  });

  String maquan;
  String tenquan;
  String diachi;
  dynamic hinhanh;
  dynamic thoigianhoatdong;
  dynamic trangthai;
  dynamic matkhau;
  String loaiquan;
  dynamic bluan;

  factory TenQuanMd.fromJson(Map<String, dynamic> json) => TenQuanMd(
        maquan: json["Maquan"],
        tenquan: json["Tenquan"],
        diachi: json["Diachi"],
        hinhanh: json["Hinhanh"],
        thoigianhoatdong: json["Thoigianhoatdong"],
        trangthai: json["Trangthai"],
        matkhau: json["Matkhau"],
        loaiquan: json["Loaiquan"],
        bluan: json["Bluan"],
      );

  Map<String, dynamic> toJson() => {
        "Maquan": maquan,
        "Tenquan": tenquan,
        "Diachi": diachi,
        "Hinhanh": hinhanh,
        "Thoigianhoatdong": thoigianhoatdong,
        "Trangthai": trangthai,
        "Matkhau": matkhau,
        "Loaiquan": loaiquan,
        "Bluan": bluan,
      };
}
