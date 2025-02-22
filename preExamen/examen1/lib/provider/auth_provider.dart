import 'package:flutter/material.dart';
import '../db/db_provider.dart';

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  String? _username;
  List<String> _allUsers = [];

  AuthProvider() {
    _loadUsers();
  }

  bool get isAuthenticated => _isAuthenticated;
  String? get username => _username;
  List<String> get allUsers => _allUsers;

  Future<void> _loadUsers() async {
    _allUsers = await DbProvider.db.getAllUsers();
    notifyListeners();
  }

  Future<void> login(String username, String password) async {
    final user = await DbProvider.db.getUser(username);
    if (user != null && user['password'] == password) {
      _isAuthenticated = true;
      _username = username;
      await _loadUsers();
      notifyListeners();
    }
  }

  Future<void> register(String username, String password) async {
    await DbProvider.db.insertUser(username, password);
    await _loadUsers();
  }

  void logout() {
    _isAuthenticated = false;
    _username = null;
    notifyListeners();
  }
}
