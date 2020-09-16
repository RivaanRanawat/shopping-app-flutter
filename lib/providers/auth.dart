import "package:flutter/widgets.dart";
import "dart:convert";
import "package:http/http.dart" as http;

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  Future<void> _authenticate(String email, String password, String urlHandler) async {
    final url = "https://identitytoolkit.googleapis.com/v1/accounts:$urlHandler?key=AIzaSyBzjTJvEMIqxF6tumWgteXFOPh1AJ0m3xk";
    final res = await http.post(url, body: json.encode({
      "email":email,
      "password": password,
      "returnSecureToken": true,
    }));
    print(json.decode(res.body));
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, "signUp");
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, "signInWithPassword");
  }
 }