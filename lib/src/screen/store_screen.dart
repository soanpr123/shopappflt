import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/src/provider/cart.dart';
import 'package:shopapp/src/provider/category.dart';
import 'package:shopapp/src/provider/products.dart';
import 'package:shopapp/src/provider/store.dart';
import 'package:shopapp/src/widgets/app_drawer.dart';
import 'package:shopapp/src/widgets/badge.dart';
import 'package:shopapp/src/widgets/category_grid.dart';
import 'package:shopapp/src/widgets/product_grid.dart';
import 'package:shopapp/src/widgets/store_grid.dart';

import 'cart_screen.dart';


enum FilterOption { Favorites, ShowAll }

class StoreScreen extends StatefulWidget {
  static const routername="/store_screen";
  final String id;
  final String name;
  StoreScreen({this.id,this.name});
  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {

  var isInit = true;
  var isLoading = false;
  String loaiquan="";
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
      Provider.of<Stores>(context).fetchData(widget.id).then((_) {
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
          title: Text(widget.name),
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : StoreGrild());
  }
}
