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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(loadedProduct.title),
              background: Hero(
                  tag: loadedProduct.id,
                  child:
                      Image.network(loadedProduct.imageUrl, fit: BoxFit.cover)),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height: 10),
              Text(
                "₹${loadedProduct.price}",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  child: Text(
                    "${loadedProduct.description}",
                    textAlign: TextAlign.center,
                    softWrap: true,
                  )),
                  SizedBox(height: 800,), // for checking
            ]),
          ),
          
        ],
      ),
    );
  }
}
