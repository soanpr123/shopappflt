import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/src/provider/cart.dart';
import 'package:shopapp/src/provider/products.dart';
import 'package:shopapp/src/widgets/app_drawer.dart';
import 'package:shopapp/src/widgets/badge.dart';
import 'package:shopapp/src/widgets/loaimonan_grid.dart';
import 'package:shopapp/src/widgets/product_grid.dart';

import 'cart_screen.dart';


enum FilterOption { Favorites, ShowAll }

class LoaiMonAnScreen extends StatefulWidget {
  static const routername='/loaimonan';
 final String id;
 LoaiMonAnScreen({this.id});
  @override
  _LoaiMonAnScreenState createState() => _LoaiMonAnScreenState();
}

class _LoaiMonAnScreenState extends State<LoaiMonAnScreen> {
  var _showFavorites = false;
  var isInit = true;
  var isLoading = false;
  @override
  void initState() {
//  Provider.of<Products>(context).fetchData();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      setState(() {
        isLoading = true;
      });
      Provider.of<Products>(context).fetchDataDanhmuc(widget.id).then((_) {
        setState(() {
          isLoading = false;
        });
      });
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("MyShop"),
          actions: <Widget>[

            Consumer<Cart>(
              builder: (_, cart, ch) => Badge(
                child: ch,
                value: cart.itemCount.toString(),
              ),
              child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.pushNamed(context, CartScreen.routerName);
                },
              ),
            )
          ],
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : LoaiMonAnGrid());
  }
}
