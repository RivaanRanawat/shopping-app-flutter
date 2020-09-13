import "package:flutter/material.dart";
import "package:provider/provider.dart";
import '../screens/edit_product_screen.dart';
import '../widgets/app_drawer.dart';
import "../providers/product_provider.dart";
import "../widgets/user_product_item.dart";

class UserProductsScreen extends StatelessWidget {
  static const routeName = "/user-product-screen";
  @override
  Widget build(BuildContext context) {
    var productData = Provider.of<Products>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Your Products"),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routeName);
              },
            ),
          ],
        ),
        drawer: AppDrawer(),
        body: Padding(
          padding: EdgeInsets.all(15),
          child: ListView.builder(
              itemCount: productData.items.length,
              itemBuilder: (_, i) => UserProductItem(productData.items[i].id,
                  productData.items[i].title, productData.items[i].imageUrl)),
        ));
  }
}
