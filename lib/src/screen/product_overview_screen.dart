import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/src/provider/cart.dart';
import 'package:shopapp/src/provider/products.dart';
import 'package:shopapp/src/widgets/app_drawer.dart';
import 'package:shopapp/src/widgets/badge.dart';
import 'package:shopapp/src/widgets/product_grid.dart';

import 'cart_screen.dart';


enum FilterOption { Favorites, ShowAll }

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
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
      Provider.of<Products>(context).fetchData().then((_) {
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
            PopupMenuButton(
                onSelected: (FilterOption SelectedValue) {
                  setState(() {
                    if (SelectedValue == FilterOption.Favorites) {
                      _showFavorites = true;
                    } else {
                      _showFavorites = false;
                    }
                  });
                },
                icon: Icon(
                  Icons.more_vert,
                ),
                itemBuilder: (_) => [
                      PopupMenuItem(
                        child: Text('Only Favorites'),
                        value: FilterOption.Favorites,
                      ),
                      PopupMenuItem(
                        child: Text('Show All'),
                        value: FilterOption.ShowAll,
                      )
                    ]),
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
        drawer: AppDrawer(),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : Productgrid(_showFavorites));
  }
}
