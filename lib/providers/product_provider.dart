import 'package:flutter/cupertino.dart';
import '../models/http_exceptions.dart';
import "dart:convert";
import './product.dart';
import "package:http/http.dart" as http;

class Products with ChangeNotifier {
  List<Product> _items = [];

  final String authToken;
  final String userId;
  Products(this.authToken, this.userId, this._items);

  List<Product> get favItem {
    return _items.where((element) => element.isFav).toList();
  }

  List<Product> get items {
    return [..._items];
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> fetchAndSetProduct([bool filterByUser = false]) async {
   final filterString = filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    var url =
        'https://shop-flutter-app-de5c5.firebaseio.com//products.json?auth=$authToken&$filterString';
    try {
      final res = await http.get(url);
      final extractedData = json.decode(res.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      url =
          "https://shop-flutter-app-de5c5.firebaseio.com/userFavourites/$userId.json?auth=$authToken";
      final favResponse = await http.get(url);
      final favData = json.decode(favResponse.body);
      final List<Product> loadedProducts = [];
      extractedData.forEach((productId, productData) {
        loadedProducts.insert(
            0,
            Product(
              id: productId,
              description: productData["description"],
              imageUrl: productData["imageUrl"],
              price: productData["price"],
              title: productData["title"],
              isFav: favData == null ? false : favData[productId] ?? false,
            ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (err) {
      throw err;
    }
  }

  Future<void> addProduct(Product product) async {
    final url =
        "https://shop-flutter-app-de5c5.firebaseio.com/products.json?auth=$authToken";
    try {
      final res = await http.post(
        url,
        body: json.encode({
          "title": product.title,
          "description": product.description,
          "imageUrl": product.imageUrl,
          "price": product.price,
          "creatorId": userId,
        }),
      );
      final newProduct = Product(
        id: json.decode(res.body)["name"],
        description: product.description,
        imageUrl: product.imageUrl,
        price: product.price,
        title: product.title,
      );
      // _items.add(newProduct); end
      _items.insert(0, newProduct); // beggining
      notifyListeners();
    } catch (err) {
      print(err);
      throw err;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((element) => element.id == id);
    if (prodIndex >= 0) {
      final url =
          "https://shop-flutter-app-de5c5.firebaseio.com/products/$id.json?auth=$authToken";
      await http.patch(url,
          body: json.encode({
            "title": newProduct.title,
            "description": newProduct.description,
            "imageUrl": newProduct.imageUrl,
            "price": newProduct.price,
          }));
      _items[prodIndex] = newProduct;
    } else {
      print('idk what to do then hahaha');
    }
    notifyListeners();
  }

  Future<void> deleteProduct(String id) async {
    final url =
        "https://shop-flutter-app-de5c5.firebaseio.com/products/$id.json?auth=$authToken";
    final existingProductIndex =
        _items.indexWhere((element) => element.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final res = await http.delete(url);
    if (res.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpExceptions("Product could not be deleted.");
    }
    existingProduct = null;
  }
}
