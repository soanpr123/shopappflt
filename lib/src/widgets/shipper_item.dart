import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/src/models/shipperMD.dart';
import 'package:shopapp/src/provider/shipper.dart';

class ShipperItem extends StatefulWidget {
  final Shipper shipper;
  ShipperItem(this.shipper);

  @override
  _ShipperItemState createState() => _ShipperItemState();
}

class _ShipperItemState extends State<ShipperItem> {
  var _expanmore = false;
  var isselect = false;
  String mashiper = "";
  @override
  Widget build(BuildContext context) {
//    final item=Provider.of<Shipper>(context,listen: false);
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Checkbox(
              value: isselect,
              onChanged: (val) {
                setState(() {
                  isselect = val;

                  print(val);
                });
                if (isselect == true) {
                  Provider.of<Shippers>(context,listen: false).Setmashiper(widget.shipper.mashipper);
                  print(mashiper);
                }else{
                  mashiper="";
                }
              },
            ),
            title: Text(widget.shipper.ten),
            subtitle: Text("Địa chỉ : ${widget.shipper.diachi}"),
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
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("SĐT : ${widget.shipper.sdt}"),
                  Text("Ngày Sinh : ${widget.shipper.ngaySinh}"),
                ],
              ),
            )
        ],
      ),
    );
  }
}
