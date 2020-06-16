// To parse this JSON data, do
//
//     final loaiQuanAnMd = loaiQuanAnMdFromJson(jsonString);

import 'dart:convert';

List<LoaiQuanAnMd> loaiQuanAnMdFromJson(String str) => List<LoaiQuanAnMd>.from(
    json.decode(str).map((x) => LoaiQuanAnMd.fromJson(x)));

String loaiQuanAnMdToJson(List<LoaiQuanAnMd> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LoaiQuanAnMd {
  LoaiQuanAnMd({
    this.maloaiquan,
    this.tenloaiquan,
    this.hinhanh,
  });

  String maloaiquan;
  String tenloaiquan;
  String hinhanh;

  factory LoaiQuanAnMd.fromJson(Map<String, dynamic> json) => LoaiQuanAnMd(
        maloaiquan: json["Maloaiquan"],
        tenloaiquan: json["Tenloaiquan"],
        hinhanh: json["hinhanh"],
      );

  Map<String, dynamic> toJson() => {
        "Maloaiquan": maloaiquan,
        "Tenloaiquan": tenloaiquan,
        "hinhanh": hinhanh,
      };
}
