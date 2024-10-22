import 'package:exercici1/screens/contador_page.dart';
import 'package:exercici1/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SaMevaApp extends StatelessWidget{

@override
  Widget build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Center(
        child:ContadorPage(),
      ),
    );
  }
}