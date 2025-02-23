// main.dart

/*

flutter pub add firebase_core
flutter pub add firebase_auth
flutter pub add firebase_database

flutter pub add shared_preferences

flutterfire configure???


*/ 
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Examen Pràctic Sim',
      home: LoginScreen(),
    );
  }
}
