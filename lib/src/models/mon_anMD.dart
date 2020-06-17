import 'package:flutter/cupertino.dart';

class MonAnMd with ChangeNotifier {
  String mamonan;
  String maquan;
  String hinhanh;
  String giatien;
  String mota;

  MonAnMd({this.mamonan, this.maquan, this.hinhanh, this.giatien, this.mota});

  MonAnMd.fromJson(Map<String, dynamic> json) {
    mamonan = json['Mamonan'];
    maquan = json['Maquan'];
    hinhanh = json['Hinhanh'];
    giatien = json['Giatien'];
    mota = json['Mota'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Mamonan'] = this.mamonan;
    data['Maquan'] = this.maquan;
    data['Hinhanh'] = this.hinhanh;
    data['Giatien'] = this.giatien;
    data['Mota'] = this.mota;
    return data;
  }
}