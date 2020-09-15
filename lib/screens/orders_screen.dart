import "package:flutter/material.dart";
import "../providers/order.dart" show Order;
import "../widgets/order_item.dart";
import "package:provider/provider.dart";
import "../widgets/app_drawer.dart";

class OrdersScreen extends StatelessWidget {
  static const routeName = "/orders";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your orders"),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<Order>(context, listen: false).fetchAndSetOrders(),
        builder: (ctx, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snap.error == null) {
              return Consumer<Order>(
                builder: (ctx, orderData, child) => ListView.builder(
                    itemBuilder: (ctx, i) => OrderItem(orderData.orders[i]),
                    itemCount: orderData.orders.length),
              );
            }
          }
        },
      ),
    );
  }
}
