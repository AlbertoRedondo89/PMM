import 'package:flutter/material.dart';
import 'package:pruebas/pages/pagina1.dart';
import 'package:pruebas/pages/pagina2.dart';
import '';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "navegasao",
      initialRoute: "pagina1",
      routes: {
        "pagina1": (BuildContext context) => const Pagina1(),
        "pagina2": (BuildContext context) => const Pagina2()
      },
    );
  }
}