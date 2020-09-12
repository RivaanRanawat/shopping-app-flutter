import "package:flutter/foundation.dart";

class Product with ChangeNotifier{
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFav;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFav = false,
  });

  void toggleFavouriteStatus() {
    isFav = !isFav;
    notifyListeners();
  }
}
