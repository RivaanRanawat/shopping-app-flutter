import 'package:flutter/material.dart';

import '../providers/cart.dart';

class OrderItem {
  final String id;
  final double price;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({this.id, this.price, this.products, this.dateTime});
}

class Order with ChangeNotifier {
  List<OrderItem> _orders = [];
  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProducts, double total) {
    _orders.insert(
      0,
      OrderItem(
          id: DateTime.now().toString(),
          dateTime: DateTime.now(),
          price: total,
          products: cartProducts),
    );
    notifyListeners();
  }
}
