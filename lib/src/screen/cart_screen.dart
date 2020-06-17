import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/src/provider/auth.dart';

import 'package:shopapp/src/provider/cart.dart';
import 'package:shopapp/src/provider/order.dart';
import 'package:shopapp/src/provider/products.dart';
import 'package:shopapp/src/widgets/cart_item.dart';
import 'package:shopapp/src/widgets/option_buy_foood.dart';

class CartScreen extends StatelessWidget {
  static const routerName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final userid = Provider.of<Auth>(context).userId;
    final Maquan = Provider.of<Products>(context).maquan;
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
                  OrderButton(
                    cart: cart,
                    maquan: Maquan,
                    makh: userid,
                    phiship: "45000",
                  ),
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
  const OrderButton(
      {Key key,
      @required this.cart,
      @required this.maquan,
      @required this.makh,
      @required this.phiship})
      : super(key: key);

  final Cart cart;
  final String maquan;
  final String makh;
  final String phiship;
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
                showModalBottomSheet(
                    context: context,
                    builder: (_) {
                      return GestureDetector(
                        onTap: () {},
                        child: Option(
                          cart: widget.cart,
                          maquan: widget.maquan,
                          makh: widget.makh,
                          phiship: "45000",
                        ),
                        behavior: HitTestBehavior.opaque,
                      );
                    });
              }
    );
  }
}
