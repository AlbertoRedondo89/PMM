import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

int contador = 0;
final estil = const TextStyle(fontSize: 24);

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contador'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Nombre de clicks: ', style: estil),
            Text('$contador', style: estil,),
          ],
        ),
      ),floatingActionButton: FloatingActionButton(
        onPressed: () {
          contador = contador + 1;
        },
        child: const Icon(Icons.add),
        ),
    );
  }

}