import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/auth_provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _loadSavedUser();
  }

  Future<void> _loadSavedUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedUser = prefs.getString('savedUser');
    if (savedUser != null) {
      _userController.text = savedUser;
      setState(() {
        _rememberMe = true;
      });
    }
  }

  Future<void> _saveUser(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_rememberMe) {
      await prefs.setString('savedUser', username);
    } else {
      await prefs.remove('savedUser');
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _userController,
              decoration: InputDecoration(labelText: 'Usuario'),
            ),
            TextField(
              controller: _passController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Contraseña'),
            ),
            Row(
              children: [
                Checkbox(
                  value: _rememberMe,
                  onChanged: (value) {
                    setState(() {
                      _rememberMe = value!;
                    });
                  },
                ),
                Text("Recordar usuario")
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String username = _userController.text.trim();
                String password = _passController.text.trim();

                bool success = authProvider.login(username, password);
                if (success) {
                  await _saveUser(username);
                  Navigator.pushReplacementNamed(context, '/home');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Credenciales incorrectas")),
                  );
                }
              },
              child: Text("Iniciar sesión"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: Text("Crear cuenta"),
            ),
          ],
        ),
      ),
    );
  }
}
