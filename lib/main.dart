import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/src/provider/auth.dart';
import 'package:shopapp/src/provider/cart.dart';
import 'package:shopapp/src/provider/order.dart';
import 'package:shopapp/src/provider/products.dart';
import 'package:shopapp/src/screen/auth_screen.dart';
import 'package:shopapp/src/screen/cart_screen.dart';
import 'package:shopapp/src/screen/edit_product_screen.dart';
import 'package:shopapp/src/screen/oder_screen.dart';
import 'package:shopapp/src/screen/product_detail.dart';
import 'package:shopapp/src/screen/product_overview_screen.dart';
import 'package:shopapp/src/screen/splaps_screen.dart';
import 'package:shopapp/src/screen/user_product_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Auth(),
          ),
          ChangeNotifierProxyProvider<Auth, Products>(
            update: (ctx, auth, priviusProducts) => Products(
                auth.token,
                priviusProducts == null ? [] : priviusProducts.items,
                auth.userId),
          ),
          ChangeNotifierProvider.value(
            value: Cart(),
          ),
          ChangeNotifierProxyProvider<Auth, Orders>(
            update: (ctx, auth, priviusProducts) => Orders(
                auth.token,
                priviusProducts == null ? [] : priviusProducts.oder,
                auth.userId),
          ),
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
              title: 'MyShop',
              theme: ThemeData(
                  primarySwatch: Colors.purple,
                  accentColor: Colors.deepOrange,
                  fontFamily: 'Lato'),
              home: auth.isAuth
                  ? ProductOverviewScreen()
                  : FutureBuilder(
                      future: auth.tryAuoLogin(),
                      builder: (ctx, authReoutSnapshot) =>
                          authReoutSnapshot.connectionState ==
                                  ConnectionState.waiting
                              ? SplashScreen()
                              : AuthScreen(),
                    ),
              routes: {
                ProductDeltailScreen.routerName: (ctx) =>
                    ProductDeltailScreen(),
                CartScreen.routerName: (ctx) => CartScreen(),
                OrdersScreen.routeName: (ctx) => OrdersScreen(),
                UserProductScreen.routerName: (ctx) => UserProductScreen(),
                EditProductScreen.routerName: (ctx) => EditProductScreen(),
              }),
        ));
  }
}
