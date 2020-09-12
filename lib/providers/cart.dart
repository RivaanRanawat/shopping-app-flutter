import "package:flutter/material.dart";

class CartItem {
  final String id;
  final String title;
  final double price;
  final int quantity;

  CartItem(
      {@required this.id,
      @required this.title,
      @required this.price,
      @required this.quantity});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};
  Map<String, CartItem> get items {
    return {..._items};
  }

  void addItems(String prodId, double price, String title) {
    if (_items.containsKey(prodId)) {
      _items.update(
          prodId,
          (value) => CartItem(
              id: DateTime.now().toString(),
              title: value.title,
              price: value.price,
              quantity: value.quantity + 1));
    } else {
      _items.putIfAbsent(
          prodId,
          () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              price: price,
              quantity: 1));
    }
    notifyListeners();
  }

  int get productsLength {
    return _items == null? 0: _items.length;
  }
}
