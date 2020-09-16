import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import '../providers/product.dart';
import "dart:convert";
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
  final String authToken;
  final String userId;
  Order(this.authToken, this.userId ,this._orders);
  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    final url = 'https://shop-flutter-app-de5c5.firebaseio.com/orders/$userId.json?auth=$authToken';
    final response = await http.get(url);
    final List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(
        OrderItem(
          id: orderId,
          price: orderData['amount'],
          dateTime: DateTime.parse(orderData['dateTime']),
          products: (orderData['products'] as List<dynamic>)
              .map(
                (item) => CartItem(
                      id: item['id'],
                      price: item['price'],
                      quantity: item['quantity'],
                      title: item['title'],
                    ),
              )
              .toList(),
        ),
      );
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

    Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = "https://shop-flutter-app-de5c5.firebaseio.com/orders/$userId.json?auth=$authToken";
    final timestamp = DateTime.now();
    // so that we get one timestamp and not two diff timestamp
    final res = await http.post(url, body: json.encode({
      "amount": total,
      "dateTime": timestamp.toIso8601String(),
      "products": cartProducts.map((cp) => {
        "id": cp.id,
        "title": cp.title,
        "quantity": cp.quantity,
        "price": cp.price,
      }).toList()
    }));
    
    _orders.insert(
      0,
      OrderItem(
          id: json.decode(res.body)["name"],
          dateTime: timestamp,
          price: total,
          products: cartProducts),
    );
    notifyListeners();
  }
}
