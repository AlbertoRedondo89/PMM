import 'package:flutter/material.dart';

class HomePageTemp extends StatelessWidget {

  final elements = ['Element 1', 'Element 2', 'Element 3', 'Element 4']

  

  const HomePageTemp({super.key});@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Components Temp'),
      ),
      body: ListView(
        children: 
      )
    );
  }

  List<Widget> _crearElements() {
    List<Widget> llista = [];
    for (String element in elements) {
      final tempWidget = ListTile(
        title: Text(element)
      );
      llista.add(tempWidget);
      llista.add(const Divider());
    }
    /*
    OTRAS DOS FORMAS DE HACER LO MISMO

    final tempWidget = ListTil(
      title: Text(element)
    );
    llista..add(tempWidget)
          ..add(Divider));

    ---------------------------------

    elements.forEach((element) {
      llista.add(ListTile(
        title: Text(element),
      ));
      llista.add(Divider());
    });
    
    */
    return llista;
  }
  
}
