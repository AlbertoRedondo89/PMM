import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../db/db_helper.dart';

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  String? _username;

  AuthProvider() {
    _loadUser();
  }

  bool get isAuthenticated => _isAuthenticated;
  String? get username => _username;

  Future<void> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    _username = prefs.getString('username');
    _isAuthenticated = _username != null;
    notifyListeners();
  }

  Future<bool> login(String username, String password) async {
    final user = await DatabaseHelper.db.getUser(username);
    if (user != null && user['password'] == password) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', username);
      _isAuthenticated = true;
      _username = username;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> register(String username, String password) async {
    final user = await DatabaseHelper.db.getUser(username);
    if (user == null) {
      await DatabaseHelper.db.insertUser(username, password);
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    _isAuthenticated = false;
    _username = null;
    notifyListeners();
  }
}
