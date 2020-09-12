import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import "./product_item.dart";

class ProductsGrid extends StatelessWidget {
  final bool favs;
  ProductsGrid(this.favs);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final listOfProducts = favs? productsData.favItem :productsData.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: listOfProducts.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
              value: listOfProducts[i],
              child: ProductItem(),
      ),
    );
  }
}
