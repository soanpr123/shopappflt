import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shopapp/src/models/http_exception.dart';
import 'package:shopapp/src/models/loai_quan_anMD.dart';
import 'package:shopapp/src/models/mon_anMD.dart';
import 'package:shopapp/src/models/shipperMD.dart';
import 'package:shopapp/src/provider/product.dart';
import 'package:shopapp/src/utils/server.dart';

class Shippers with ChangeNotifier {
  List<Shipper> _items = [];
  var _showOnlyFavorites = false;
  List<Shipper> get items => _items;
String _mashiper;

  String get mashiper => _mashiper;

  void Setmashiper(String value) {
    _mashiper = value;
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Server.SHIPPER);
      final extraData = json.decode(response.body);
      if (extraData == null) {
        return;
      }
      print(extraData);
      final List<Shipper> loaderProduct =
      (extraData as List).map((map) => Shipper.fromJson(map)).toList();
      for (Shipper shipper in loaderProduct) {
        _items.add(Shipper(
          mashipper: shipper.mashipper,
          ten: shipper.ten,
          ngaySinh: shipper.ngaySinh,
          diachi: shipper.diachi,
          sdt: shipper.sdt,
          hinhanh: shipper.hinhanh,
          matkhau: shipper.matkhau
           ));
      }

      _items = loaderProduct;
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }
}
