import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shopapp/src/provider/order.dart';


class OrdersItems extends StatefulWidget {
  final OdersItem order;
  OrdersItems(this.order);

  get amount => null;

  get dateTime => null;

  @override
  _OrdersItemsState createState() => _OrdersItemsState();
}

class _OrdersItemsState extends State<OrdersItems> {
  var _expanmore = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('\$${widget.order.amount}'),
            subtitle: Text(
                DateFormat('dd-MM-yyyy hh:mm').format(widget.order.dateTime)),
            trailing: IconButton(
              icon: Icon(_expanmore ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanmore = !_expanmore;
                });
              },
            ),
          ),
          if (_expanmore)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 4),
              height: min(widget.order.product.length * 20.0 + 10, 180),
              child: ListView(
                children: widget.order.product
                    .map((prod) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              prod.title,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${prod.quantity}x \$${prod.price}',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                          ],
                        )).toList(),
              ),
            )
        ],
      ),
    );
  }
}
