import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  String? _username;
  final Map<String, String> _dummyUsers = {
    "admin": "1234",
    "user": "password",
  };

  bool login(String username, String password) {
    if (_dummyUsers[username] == password) {
      _username = username;
      notifyListeners();
      return true;
    }
    return false;
  }

  void logout() {
    _username = null;
    notifyListeners();
  }

  String get username => _username ?? "Usuario";
}
