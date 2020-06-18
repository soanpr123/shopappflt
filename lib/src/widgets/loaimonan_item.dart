import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/src/models/mon_anMD.dart';

import 'package:shopapp/src/provider/auth.dart';
import 'package:shopapp/src/provider/cart.dart';
import 'package:shopapp/src/provider/product.dart';
import 'package:shopapp/src/screen/product_detail.dart';

class LoaiMonAnItem extends StatelessWidget {
//  final String id;
//  final String title;
//  final String imageUrl;
//  ProductItem(this.id, this.title, this.imageUrl);
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<MonAnMd>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final authData=Provider.of<Auth>(context,listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDeltailScreen.routerName, arguments: product.mamonan);
          },
          child: Image.network(
            product.hinhanh,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          title: Text(
            product.mota,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.black87,
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              cart.addItem(product.mamonan, double.parse(product.giatien), product.mota);
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('Add item to cart'),
                duration: Duration(seconds: 2),
                action: SnackBarAction(
                  label: 'Undo',
                  onPressed: (){
                    cart.removeSinglItem(product.mamonan);
                  },
                ),
              ));
            },
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
