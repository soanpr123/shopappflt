import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/src/models/loai_quan_anMD.dart';
import 'package:shopapp/src/models/mon_anMD.dart';

import 'package:shopapp/src/provider/auth.dart';
import 'package:shopapp/src/provider/cart.dart';
import 'package:shopapp/src/provider/product.dart';
import 'package:shopapp/src/screen/product_detail.dart';
import 'package:shopapp/src/screen/store_screen.dart';
import 'package:shopapp/src/widgets/category_grid.dart';

class CategoryItem extends StatelessWidget {
//  final String id;
//  final String title;
//  final String imageUrl;
//  ProductItem(this.id, this.title, this.imageUrl);
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<LoaiQuanAnMd>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext ctx)=>StoreScreen(id: product.maloaiquan,name: product.tenloaiquan,)));
          },
          child: Image.network(
            product.hinhanh,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          title: Text(
            product.tenloaiquan,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.black87,
        ),
      ),
    );
  }
}
