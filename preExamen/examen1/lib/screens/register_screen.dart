import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/auth_provider.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Registrar Usuario")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Crear una nueva cuenta:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: "Usuario"),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: "Contraseña"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final username = _usernameController.text;
                final password = _passwordController.text;

                if (username.isNotEmpty && password.isNotEmpty) {
                  await authProvider.register(username, password);
                  Navigator.pushReplacementNamed(context, '/home');
                } else {
                  // Mostrar mensaje de error si el formulario está vacío
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Por favor ingresa todos los campos')));
                }
              },
              child: Text("Registrar"),
            ),
          ],
        ),
      ),
    );
  }
}
