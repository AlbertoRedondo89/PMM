
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/auth_provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Bienvenido ${auth.username}')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            auth.logout();
            Navigator.pushReplacementNamed(context, '/');
          },
          child: Text('Cerrar sesión'),
        ),
      ),
    );
  }
}
