import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import "../providers/product_provider.dart";

class ProductDetailsScreen extends StatelessWidget {
  static const routeName = "/product-details";
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.39,
              width: double.infinity,
              child: Image.network(loadedProduct.imageUrl, fit: BoxFit.cover),
            ),
            SizedBox(height: 10),
            Text("₹${loadedProduct.price}", style: TextStyle(color: Colors.grey, fontSize: 20,),),
            SizedBox(height: 10),
            Container(padding: EdgeInsets.symmetric(vertical: 10), width: double.infinity ,child: Text("${loadedProduct.description}", textAlign: TextAlign.center, softWrap: true,)),
          ],
        ),
      ),
    );
  }
}
