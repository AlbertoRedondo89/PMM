import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  final missatge = "Hola que ase";

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Home(missatge),
    );
  }
}

class Home extends StatelessWidget {
  final missatge;
  Home({super.key, required this.missatge});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(missatge),
    );
  }
}
