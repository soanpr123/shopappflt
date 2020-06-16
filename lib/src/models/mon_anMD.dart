// To parse this JSON data, do
//
//     final monAnMd = monAnMdFromJson(jsonString);

import 'dart:convert';

List<MonAnMd> monAnMdFromJson(String str) =>
    List<MonAnMd>.from(json.decode(str).map((x) => MonAnMd.fromJson(x)));

String monAnMdToJson(List<MonAnMd> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MonAnMd {
  MonAnMd({
    this.mamonan,
    this.maquan,
    this.hinhanh,
    this.giatien,
    this.mota,
  });

  String mamonan;
  String maquan;
  String hinhanh;
  String giatien;
  String mota;

  factory MonAnMd.fromJson(Map<String, dynamic> json) => MonAnMd(
        mamonan: json["Mamonan"],
        maquan: json["Maquan"],
        hinhanh: json["Hinhanh"],
        giatien: json["Giatien"],
        mota: json["Mota"],
      );

  Map<String, dynamic> toJson() => {
        "Mamonan": mamonan,
        "Maquan": maquan,
        "Hinhanh": hinhanh,
        "Giatien": giatien,
        "Mota": mota,
      };
}
