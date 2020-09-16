import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import './helpers/custom_routes.dart';
import './screens/splash_screen.dart';
import './screens/auth_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/orders_screen.dart';
import './screens/user_products_screen.dart';
import './providers/cart.dart';
import "./providers/auth.dart";
import './providers/product_provider.dart';
import './screens/product_details_screen.dart';
import './screens/products_overview_screen.dart';
import "./screens/cart_screen.dart";
import "./providers/order.dart";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => Auth(),
          ),
          ChangeNotifierProxyProvider<Auth, Products>(
            update: (ctx, auth, previousProducts) => Products(
                auth.token,
                auth.userId,
                previousProducts == null ? [] : previousProducts.items),
            create: null,
          ),
          ChangeNotifierProvider(
            create: (ctx) => Cart(),
          ),
          ChangeNotifierProxyProvider<Auth, Order>(
            update: (ctx, auth, previousOrders) => Order(
                auth.token,
                auth.userId,
                previousOrders == null ? [] : previousOrders.orders),
            create: null,
          ),
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
            title: 'RRRShop',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              accentColor: Colors.red,
              fontFamily: "Lato",
              pageTransitionsTheme: PageTransitionsTheme(
                builders: {
                  TargetPlatform.android: CustomPageTransitionBuilder(),
                  TargetPlatform.iOS: CustomPageTransitionBuilder(),
                }
              )
            ),
            home: auth.isAuth
                ? ProductsOverviewScreen()
                : FutureBuilder(
                    future: auth.autoLogin(),
                    builder: (ctx, snap) => snap.connectionState == ConnectionState.waiting? SplashScreen() : AuthScreen(),
                  ),
            routes: {
              ProductDetailsScreen.routeName: (ctx) => ProductDetailsScreen(),
              CartScreen.routeName: (ctx) => CartScreen(),
              OrdersScreen.routeName: (ctx) => OrdersScreen(),
              UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
              EditProductScreen.routeName: (ctx) => EditProductScreen(),
            },
          ),
        ));
  }
}
