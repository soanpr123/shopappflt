import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shopapp/src/models/http_exception.dart';
import 'package:shopapp/src/provider/product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [];
  final String authToken;
  final String userId;
  Products(this.authToken, this._items, this.userId);
  var _showOnlyFavorites = false;
  List<Product> get favoritesItem {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }


  List<Product> get items => _items;

  Future<void> fetchData([bool filterByUser = false]) async {

    final filterString=filterByUser?'orderBy="creatorId"&equalTo="$userId" ' : '';
    var url =
        'https://shopapp-7ddb2.firebaseio.com/products.json?auth=$authToken&$filterString';
    try {
      final response = await http.get(url);
      final extraData = json.decode(response.body) as Map<String, dynamic>;
      if (extraData == null) {
        return;
      }
      url =
          'https://shopapp-7ddb2.firebaseio.com/userFavorites/$userId.json?auth=$authToken';
      final favoritesResponse = await http.get(url);
      final fovoritesData = json.decode(favoritesResponse.body);
      final List<Product> loaderProduct = [];
      extraData.forEach((proId, proData) {
          loaderProduct.add(Product(
            id: proId,
            title: proData['title'],
            description: proData['description'],
            price: proData['pirce'],
            imageUrl: proData['imageUrl'],
            isFavorite:
                fovoritesData == null ? false : fovoritesData[proId] ?? false));
      });
      _items = loaderProduct;
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> addProducts(Product product) async {
    final url =
        'https://shopapp-7ddb2.firebaseio.com/products.json?auth=$authToken';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'pirce': product.price,
          'creatorId':userId
        }),
      );
      print(json.decode(response.body));
      final newproduct = Product(
          title: product.title,
          price: product.price,
          description: product.description,
          imageUrl: product.imageUrl,
          id: json.decode(response.body)['name']);
      _items.add(newproduct);
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Product findByid(String id) {
    return _items.firstWhere((pord) => pord.id == id);
  }

  deleteProducts(String id) async {
    final url =
        'https://shopapp-7ddb2.firebaseio.com/products/$id.json?auth=$authToken';
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    existingProduct = null;
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url =
          'https://shopapp-7ddb2.firebaseio.com/products/$id.json?auth=$authToken';
      await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'pirce': newProduct.price
          }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }
}
