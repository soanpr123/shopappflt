import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'package:shopapp/src/provider/cart.dart';


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
  Orders(this.authToken,this._oder,this.userId);


  List<OdersItem> get oder => _oder;

  Future<void> addOrder(List<CartItem> cartProduct, double total) async {
    final url = 'https://shopapp-7ddb2.firebaseio.com/order/$userId.json?auth=$authToken';
    final timestamp = DateTime.now();
    final response = await http.post(url,
        body: json.encode({
          'id': DateTime.now().toString(),
          'amount': total,
          'product': cartProduct
              .map((cp) => {
                    'id': cp.id,
                    'title': cp.title,
                    'quantity': cp.quantity,
                    'price': cp.price
                  })
              .toList(),
          'dateTime': timestamp.toIso8601String(),
        }));
    _oder.insert(
        0,
        OdersItem(
            id: json.decode(response.body)['name'],
            amount: total,
            product: cartProduct,
            dateTime: timestamp));
    notifyListeners();
  }

  Future<void> fetchData() async {
    final url = 'https://shopapp-7ddb2.firebaseio.com/order/$userId.json?auth=$authToken';
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
