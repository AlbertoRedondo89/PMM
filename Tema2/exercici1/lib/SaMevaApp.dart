import 'package:exercici1/screens/contador_page.dart';
import 'package:exercici1/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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