import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shopapp/src/models/http_exception.dart';
import 'package:shopapp/src/models/mon_anMD.dart';
import 'package:shopapp/src/provider/product.dart';
import 'package:shopapp/src/utils/server.dart';

class Products with ChangeNotifier {
  List<MonAnMd> _items = [];
  final String authToken;
  final String userId;
  Products(this.authToken, this._items, this.userId);
  var _showOnlyFavorites = false;
  List<MonAnMd> get items => _items;
  String _maquan;

  String get maquan => _maquan;

  void Setmaquan(String value) {
    _maquan = value;
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Server.ALL_MONAN);
      final extraData = json.decode(response.body);
      print(extraData);
      if (extraData == null) {
        return;
      }
      final List<MonAnMd> loaderProduct =
          (extraData as List).map((map) => MonAnMd.fromJson(map)).toList();
      for (MonAnMd monAnMd in loaderProduct) {
        _items.add(MonAnMd(
            mamonan: monAnMd.mamonan,
            maquan: monAnMd.maquan,
            hinhanh: monAnMd.hinhanh,
            giatien: monAnMd.giatien,
            mota: monAnMd.mota));
      }
      _items = loaderProduct;
      print(_items.length);
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> fetchDataDanhmuc(String maquanan) async {
    try {
      final response = await http.post(Server.MONAN,
          body: json.encode({'Maquan': maquanan}));
      final extraData = json.decode(response.body);
      print(extraData);
      if (extraData == null) {
        return;
      }
      final List<MonAnMd> loaderProduct =
          (extraData as List).map((map) => MonAnMd.fromJson(map)).toList();
      for (MonAnMd monAnMd in loaderProduct) {
        _items.add(MonAnMd(
            mamonan: monAnMd.mamonan,
            maquan: monAnMd.maquan,
            hinhanh: monAnMd.hinhanh,
            giatien: monAnMd.giatien,
            mota: monAnMd.mota));
      }
      _items = loaderProduct;
      print(_items.length);
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  MonAnMd findByid(String id) {
    return _items.firstWhere((pord) => pord.mamonan == id);
  }
}
