import "package:flutter/material.dart";
import '../screens/user_products_screen.dart';
import '../screens/orders_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(child: Column(children: [
      AppBar(title: Text("Hello Rivaan"), automaticallyImplyLeading: false,),
      ListTile(leading: Icon(Icons.shop), title: Text("Shop"), onTap: () {
        Navigator.of(context).pushReplacementNamed("/");
      },),
      Divider(),
      ListTile(leading: Icon(Icons.payment), title: Text("Orders"), onTap: () {
        Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);
      },),
      Divider(),
      ListTile(leading: Icon(Icons.camera), title: Text("Your Products"), onTap: () {
        Navigator.of(context).pushReplacementNamed(UserProductsScreen.routeName);
      },),
    ],),);
  }
}