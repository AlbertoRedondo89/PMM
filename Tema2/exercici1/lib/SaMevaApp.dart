import 'package:exercici1/screens/contador_page.dart';
import 'package:flutter/material.dart';

class SaMevaApp extends StatelessWidget{
  const SaMevaApp({super.key});


@override
  Widget build(context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Center(
        child:ContadorPage(),
      ),
    );
  }
}