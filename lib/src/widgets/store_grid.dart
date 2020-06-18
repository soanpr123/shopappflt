import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/src/provider/category.dart';

import 'package:shopapp/src/provider/products.dart';
import 'package:shopapp/src/provider/store.dart';
import 'package:shopapp/src/widgets/category_item.dart';
import 'package:shopapp/src/widgets/product_item.dart';
import 'package:shopapp/src/widgets/store_item.dart';


class StoreGrild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Stores>(context);
    final products =productData.items;
    return GridView.builder(
        padding: const EdgeInsets.all(10.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemCount: products.length,
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
//              create: (c)=>products[i],
          value: products[i],
          child: StoreItem(
//                  products[i].id, products[i].title, products[i].imageUrl
          ),
        ));
  }
}
