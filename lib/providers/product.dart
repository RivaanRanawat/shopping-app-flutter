import "package:flutter/foundation.dart";
import "package:http/http.dart" as http;
import "dart:convert";

class Product with ChangeNotifier {
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

  Future<void> toggleFavouriteStatus(String token, String userId) async {
    final oldStatus = isFav;
    isFav = !isFav;
    notifyListeners();
    final url =
        "https://shop-flutter-app-de5c5.firebaseio.com/userFavourites/$userId/$id.json?auth=$token";
    try {
      final res = await http.put(url,
          body: json.encode(
            isFav,
          ),);
      if (res.statusCode >= 400) {
        isFav = oldStatus;
        notifyListeners();
      }
    } catch (err) {
      isFav = oldStatus;
      notifyListeners();
    }
  }
}
