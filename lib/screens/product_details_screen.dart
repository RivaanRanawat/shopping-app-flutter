import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import "../providers/product_provider.dart";

class ProductDetailsScreen extends StatelessWidget {
  static const routeName = "/product-details";
  @override
  Widget build(BuildContext context) {

    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadedProduct = Provider.of<Products>(context, listen: false).findById(productId);
    return Scaffold(appBar: AppBar(title: Text(loadedProduct.title),));
  }
}