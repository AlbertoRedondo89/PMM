import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class User {
  final String name;
  final int age;

  User({required this.name, required this.age});
}

class UserListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtener el UserProvider
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Usuarios"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Agregar un nuevo usuario de ejemplo
              userProvider.addUser(User(name: 'Nuevo Usuario', age: 18));
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: userProvider.users.length,  // Usar la lista de usuarios desde el provider
          itemBuilder: (context, index) {
            final user = userProvider.users[index];
            
            return ListTile(
              leading: Icon(Icons.person),
              title: Text(user.name),
              subtitle: Text('Edad: ${user.age}'),
              onTap: () {
                print('Usuario seleccionado: ${user.name}');
              },
            );
          },
        ),
      ),
    );
  }
}

class UserProvider with ChangeNotifier {
  List<User> _users = [];

  List<User> get users => _users;

  // Agregar usuario
  void addUser(User user) {
    _users.add(user);
    notifyListeners();
  }

  // Eliminar usuario
  void removeUser(User user) {
    _users.remove(user);
    notifyListeners();
  }
}

