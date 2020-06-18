import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shopapp/src/models/http_exception.dart';
import 'package:shopapp/src/models/loai_quan_anMD.dart';
import 'package:shopapp/src/models/mon_anMD.dart';
import 'package:shopapp/src/provider/product.dart';
import 'package:shopapp/src/utils/server.dart';

class Categorys with ChangeNotifier {
  List<LoaiQuanAnMd> _items = [];
  var _showOnlyFavorites = false;
  List<LoaiQuanAnMd> get items => _items;

  Future<void> fetchData() async {
    try {
      final response = await http.get(Server.LOAIQUAN);
      final extraData = json.decode(response.body);
      if (extraData == null) {
        return;
      }
      final List<LoaiQuanAnMd> loaderProduct =
      (extraData as List).map((map) => LoaiQuanAnMd.fromJson(map)).toList();
      for (LoaiQuanAnMd monAnMd in loaderProduct) {
        _items.add(LoaiQuanAnMd(
            maloaiquan: monAnMd.maloaiquan,
            tenloaiquan: monAnMd.tenloaiquan,
            hinhanh: monAnMd.hinhanh));
      }

      _items = loaderProduct;
         notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  LoaiQuanAnMd findByid(String id) {
    return _items.firstWhere((pord) => pord.maloaiquan == id);
  }
}
