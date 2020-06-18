import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'package:shopapp/src/provider/cart.dart';
import 'package:shopapp/src/utils/server.dart';

class OdersItem {
  final String id;
  final double amount;
  final List<CartItem> product;
  final DateTime dateTime;
  OdersItem(
      {@required this.id,
      @required this.amount,
      @required this.product,
      @required this.dateTime});
}

class Orders with ChangeNotifier {
  List<OdersItem> _oder = [];

  final String authToken;
  final String userId;
  Orders(this.authToken, this._oder, this.userId);
String _respone;

  String get respone => _respone;

  List<OdersItem> get oder => _oder;

  Future<void> addOrder(
      List<CartItem> cartProduct,
      int soluong,
      double total,
      String Maquan,
      String Makh,
      String Mashipper,
      String Hinhthuctt,
      String Phiship,
      ) async {
    final timestamp = DateTime.now();
    final response = await http.post(Server.DONHANG,
        body: json.encode({
          "Maquan": Maquan,
          "Makh": Makh,
          "Soluong": soluong,
          "Mashipper": Mashipper,
          "Tongtien": total,
          "Hinhthuctt": Hinhthuctt,
          "Tgdat": timestamp.toIso8601String(),
          "Tggiao": timestamp.toIso8601String(),
          "Phiship": Phiship
        }));
    var data=response.body;
if(data=="ok"){
  print("them thành công $data");
  _respone="ok";
  print("ok nhé $_respone");
}
    notifyListeners();
  }

  Future<void> fetchData() async {
    final url =
        'https://shopapp-7ddb2.firebaseio.com/order/$userId.json?auth=$authToken';
    final response = await http.get(url);
    final List<OdersItem> loaderOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderId, olderData) {
      loaderOrders.add(OdersItem(
          id: orderId,
          amount: olderData['amount'],
          product: (olderData['product'] as List<dynamic>)
              .map((item) => CartItem(
                  id: item['id'],
                  price: item['price'],
                  quantity: item['quantity'],
                  title: item['title']))
              .toList(),
          dateTime: DateTime.parse(olderData['dateTime'])));
    });
    _oder = loaderOrders.reversed.toList();
    notifyListeners();
  }
}
