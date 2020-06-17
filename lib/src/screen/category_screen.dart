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

import 'cart_screen.dart';


enum FilterOption { Favorites, ShowAll }

class CategoryScreen extends StatefulWidget {
  static const routername="/Category_screen";
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

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
      Provider.of<Categorys>(context).fetchData().then((_) {
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
          title: Text("Danh mục"),
        ),
        drawer: AppDrawer(),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : CategoryGrild());
  }
}
