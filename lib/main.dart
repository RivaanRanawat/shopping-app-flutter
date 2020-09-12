import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import './providers/cart.dart';
import './providers/product_provider.dart';
import './screens/product_details_screen.dart';
import './screens/products_overview_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (ctx) => Products(),),
      ChangeNotifierProvider(create: (ctx) => Cart(),),
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
        },
      ),
    );
  }
}
