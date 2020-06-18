import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shopapp/src/models/http_exception.dart';
import 'package:shopapp/src/models/loai_quan_anMD.dart';
import 'package:shopapp/src/models/mon_anMD.dart';
import 'package:shopapp/src/models/ten_quanMD.dart';
import 'package:shopapp/src/provider/product.dart';
import 'package:shopapp/src/utils/server.dart';

class Stores with ChangeNotifier {
  List<TenQuanMd> _items = [];
  var _showOnlyFavorites = false;
  List<TenQuanMd> get items => _items;

  Future<void> fetchData(String maloaiquan) async {
    try {
      final response = await http.post(Server.TENQUAN,
          body: json.encode({'loaiquan': maloaiquan}));
      final extraData = json.decode(response.body);
      print(extraData);
      if (extraData == null) {
        print("bị null");
      }
      final List<TenQuanMd> loaderProduct =
          (extraData as List).map((map) => TenQuanMd.fromJson(map)).toList();
      for (TenQuanMd quanMd in loaderProduct) {
        _items.add(TenQuanMd(
          maquan: quanMd.maquan,
          tenquan: quanMd.tenquan,
          diachi: quanMd.diachi,
          hinhanh: quanMd.hinhanh,
          thoigianhoatdong: quanMd.thoigianhoatdong,
          trangthai: quanMd.trangthai,
          matkhau: quanMd.maquan,
          loaiquan: quanMd.loaiquan,
          bluan: quanMd.bluan,
        ));
      }
      _items = loaderProduct;
      print(_items.length);
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  TenQuanMd findByid(String id) {
    return _items.firstWhere((pord) => pord.maquan == id);
  }
}
