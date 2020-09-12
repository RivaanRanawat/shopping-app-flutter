import "package:flutter/material.dart";
import "../providers/order.dart" show Order;
import "../widgets/order_item.dart";
import "package:provider/provider.dart";
import "../widgets/app_drawer.dart";

class OrdersScreen extends StatelessWidget {
  static const routeName = "/orders";
  @override
  Widget build(BuildContext context) {
    var orderData = Provider.of<Order>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your orders"),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(itemBuilder: (ctx, i) => OrderItem(orderData.orders[i]), itemCount: orderData.orders.length),
    );
  }
}
