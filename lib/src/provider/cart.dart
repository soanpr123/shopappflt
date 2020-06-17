import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem(
  {
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _item = {};


  Map<String, CartItem> get item => _item;

  int get itemCount {
    return _item.length;
  }
  int get quaity{
    int quaity=0;
    _item.forEach((key, value) {
      quaity=value.quantity;
    });
    return quaity;
  }
double get totalAmount{
    var total=0.0;
    _item.forEach((key,cartitem){
total+=cartitem.price*cartitem.quantity;
    });
    return total;
}
void removeItem(String productID){
    _item.remove(productID);
    notifyListeners();
}
  void addItem(String productId, double price, String title) {
    if (_item.containsKey(productId)) {
      ////change
      _item.update(
          productId,
          (existingCartItem) => CartItem(
              id: existingCartItem.id,
              title: existingCartItem.title,
              price: existingCartItem.price,
              quantity: existingCartItem.quantity + 1

          ));
    } else {
      _item.putIfAbsent(
          productId,
          () => CartItem(
                id: DateTime.now().toString(),
                title: title,
                quantity: 1,
                price: price,
              ));
    }
    notifyListeners();
  }
  void removeSinglItem(String productId){
if(!_item.containsKey(productId)){
  return;
}
if(_item[productId].quantity>1){
  _item.update(productId, (exitingProductItem)=>CartItem(
    id: exitingProductItem.id,
    title: exitingProductItem.title,
    price: exitingProductItem.price,
    quantity: exitingProductItem.quantity-1

  ));
}else{
  _item.remove(productId);
}
notifyListeners();
  }
  void clear(){
    _item={};
    notifyListeners();
}
}
