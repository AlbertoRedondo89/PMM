import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/auth_provider.dart';

class UsersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Usuarios Registrados")),
      body: ListView.builder(
        itemCount: authProvider.allUsers.length,
        itemBuilder: (context, index) {
          final user = authProvider.allUsers[index];
          return ListTile(
            title: Text(user['username']),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _showUpdateDialog(context, user['username']),
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    authProvider.deleteUser(user['username']);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showUpdateDialog(BuildContext context, String username) {
    final TextEditingController _passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Actualizar Contraseña"),
        content: TextField(
          controller: _passwordController,
          decoration: InputDecoration(labelText: "Nueva Contraseña"),
          obscureText: true,
        ),
        actions: [
          TextButton(
            child: Text("Cancelar"),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text("Actualizar"),
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false)
                  .updatePassword(username, _passwordController.text);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
