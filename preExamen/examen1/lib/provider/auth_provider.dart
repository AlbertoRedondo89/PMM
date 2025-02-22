import 'package:flutter/material.dart';
import '../database/db_provider.dart';

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  String? _username;
  List<Map<String, dynamic>> _allUsers = [];

  AuthProvider() {
    _loadUsers();
  }

  bool get isAuthenticated => _isAuthenticated;
  String? get username => _username;
  List<Map<String, dynamic>> get allUsers => _allUsers;

  Future<void> _loadUsers() async {
    _allUsers = await DbProvider.db.getAllUsers();
    notifyListeners();
  }

  // Registrar nuevo usuario
  Future<void> register(String username, String password) async {
    await DbProvider.db.insertUser(username, password);
    await _loadUsers(); // Recargamos la lista de usuarios después de agregar uno
  }

  // Login de usuario
  Future<void> login(String username, String password) async {
    final user = await DbProvider.db.getUser(username);
    if (user != null && user['password'] == password) {
      _isAuthenticated = true;
      _username = username;
      await _loadUsers();
      notifyListeners();
    }
  }

  // Actualizar contraseña
  Future<void> updatePassword(String username, String newPassword) async {
    await DbProvider.db.updateUser(username, newPassword);
    await _loadUsers(); // Recargamos la lista después de actualizar
  }

  // Eliminar usuario
  Future<void> deleteUser(String username) async {
    await DbProvider.db.deleteUser(username);
    if (_username == username) {
      logout(); // Si eliminamos al usuario autenticado, hacemos logout
    }
    await _loadUsers();
  }

  // Logout
  void logout() {
    _isAuthenticated = false;
    _username = null;
    notifyListeners();
  }
}
