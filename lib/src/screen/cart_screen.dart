import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shopapp/src/provider/cart.dart';
import 'package:shopapp/src/provider/order.dart';
import 'package:shopapp/src/widgets/cart_item.dart';


class CartScreen extends StatelessWidget {
  static const routerName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                children: <Widget>[
                  Text(
                    "Total",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Chip(
                    label: Text('\$${cart.totalAmount}'),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  OrderButton(cart: cart),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, i) => CartItems(
                cart.item.values.toList()[i].id,
                cart.item.keys.toList()[i],
                cart.item.values.toList()[i].quantity,
                cart.item.values.toList()[i].price,
                cart.item.values.toList()[i].title,
              ),
              itemCount: cart.item.length,
            ),
          )
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var isLoading = false;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: isLoading ? CircularProgressIndicator() : Text("ODER NOW"),
      onPressed: (widget.cart.totalAmount <= 0 || isLoading)
          ? null
          : () async {
              if (widget.cart.item.length <= 0) {
                print("no item");
              } else {
                setState(() {
                  isLoading = true;
                });
                await Provider.of<Orders>(context, listen: false).addOrder(
                    widget.cart.item.values.toList(), widget.cart.totalAmount);
                setState(() {
                  isLoading = false;
                });
                widget.cart.clear();
              }
            },
      textColor: Theme.of(context).primaryColor,
    );
  }
}
