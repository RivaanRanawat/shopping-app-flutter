import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import 'package:shopping_app/screens/orders_screen.dart';
import './providers/cart.dart';
import './providers/product_provider.dart';
import './screens/product_details_screen.dart';
import './screens/products_overview_screen.dart';
import "./screens/cart_screen.dart";
import "./providers/order.dart";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (ctx) => Products(),),
      ChangeNotifierProvider(create: (ctx) => Cart(),),
      ChangeNotifierProvider(create: (ctx) => Order(),),
    ],
          child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.red,
          fontFamily: "Lato",
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailsScreen.routeName: (ctx) => ProductDetailsScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
        },
      ),
    );
  }
}
