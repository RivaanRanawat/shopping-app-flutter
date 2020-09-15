import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import '../providers/order.dart';
import '../providers/cart.dart' show Cart;
import "../widgets/cart_item.dart";

class CartScreen extends StatelessWidget {
  static const routeName = "/cart-screen";
  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<Cart>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Your Cart"),
        ),
        body: Column(
          children: [
            Card(
              margin: EdgeInsets.all(15),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(fontSize: 20),
                    ),
                    Spacer(),
                    Chip(
                      label: Text(
                        "₹${cart.totalPrice}",
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    OrderButton(cart: cart),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: cart.items.length,
                itemBuilder: (ctx, i) => CartItem(
                  id: cart.items.values.toList()[i].id,
                  productId: cart.items.keys.toList()[i],
                  price: cart.items.values.toList()[i].price,
                  quantity: cart.items.values.toList()[i].quantity,
                  title: cart.items.values.toList()[i].title,
                ),
              ),
            ),
          ],
        ));
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: _isLoading? CircularProgressIndicator() :Text("ORDER NOW"),
      textColor: Theme.of(context).primaryColor,
      onPressed: (widget.cart.totalPrice <=0 || _isLoading) ? null : () async {
        setState(() {
          _isLoading = true;
        });
        await Provider.of<Order>(context, listen: false).addOrder(widget.cart.items.values.toList(), widget.cart.totalPrice);
        setState(() {
          _isLoading = false;
        });
        widget.cart.clear();
      },
    );
  }
}
