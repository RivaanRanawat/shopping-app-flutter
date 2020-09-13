import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final String title;
  final double price;
  final int quantity;

  CartItem({this.id, this.title, this.price, this.quantity, this.productId});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).accentColor,
        child: Icon(Icons.delete, color: Colors.white,),
        height: 30,
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        alignment: Alignment.centerRight,
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen:false).removeItem(productId);
        Scaffold.of(context).hideCurrentSnackBar();
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Deleted Item From Cart!"),
                    backgroundColor: Theme.of(context).accentColor,
                    duration: Duration(seconds: 2)
                  ),
                );
      },
      child: Card(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: ListTile(
            leading: CircleAvatar(
              child: FittedBox(child: Text("₹$price")),
            ),
            title: Text(title),
            subtitle: Text("Total: ₹${(price * quantity)}"),
            trailing: Text("${quantity} x"),
          )
          ),
    );
  }
}
