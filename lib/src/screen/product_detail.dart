import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shopapp/src/provider/products.dart';

class ProductDeltailScreen extends StatelessWidget {
//  final String title;
//  final double price;
//  ProductDeltailScreen(this.title,this.price);
  static const routerName = '/product-detail';
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final loaderProduct =
        Provider.of<Products>(context, listen: false).findByid(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loaderProduct.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                loaderProduct.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '\$${loaderProduct.price}',
              style: TextStyle(color: Colors.grey, fontSize: 20),
            ),
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: Text(loaderProduct.description,textAlign: TextAlign.center,softWrap: true,))
          ],
        ),
      ),
    );
  }
}
