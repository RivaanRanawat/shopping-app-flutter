import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:shopping_app/providers/product_provider.dart';
import '../screens/cart_screen.dart';
import '../providers/cart.dart';
import "../widgets/products_grid.dart";
import "../widgets/badge.dart";
import "../widgets/app_drawer.dart";

enum ShowProducts {
  Favourites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var fav = false;
  var isInit = true;
  var isLoading = false;

  void showFav() {
    fav = true;
  }

  void showAll() {
    fav = false;
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      setState(() {
        isLoading = true;
      });
      Provider.of<Products>(context).fetchAndSetProduct().then((_) {
        setState(() {
          isLoading = false;
        });
      });
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("RRR Shop"),
          actions: [
            PopupMenuButton(
              onSelected: (ShowProducts value) {
                setState(() {
                  if (value == ShowProducts.Favourites) {
                    showFav();
                  } else {
                    showAll();
                  }
                });
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => [
                PopupMenuItem(
                  child: Text("Only Favourites"),
                  value: ShowProducts.Favourites,
                ),
                PopupMenuItem(
                  child: Text("All Products"),
                  value: ShowProducts.All,
                ),
              ],
            ),
            Consumer<Cart>(
              builder: (_, cart, ch) => Badge(
                child: ch,
                value: cart.productsLength.toString(),
              ),
              child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
              ),
            )
          ],
        ),
        drawer: AppDrawer(),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ProductsGrid(fav),
      ),
    );
  }
}
