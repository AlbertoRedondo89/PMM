import 'package:flutter/material.dart';

class ContadorPage extends StatefulWidget{
  const ContadorPage({super.key});


@override
createState() {
    return _ContadorPageState();
  }
/*
@override
createState() => _ContadorPageState();

}
*/
}

class _ContadorPageState extends State<ContadorPage> {

int _contador = 0;
final _estil = const TextStyle(fontSize: 24);

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contador amb Stateful'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Nombre de clicks: ', style: _estil),
            Text('$_contador', style: _estil,),
          ],
        ),
      ),floatingActionButton: _creaBotons(),
    );
  }


  Widget _creaBotons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        const SizedBox(width: 30.0,),
        FloatingActionButton(onPressed: _restart, child: const Icon(Icons.exposure_zero)),
        const Expanded(child: SizedBox()),
        FloatingActionButton(onPressed: _restar, child: const Icon(Icons.remove)),
        const SizedBox(width: 5.0),
        FloatingActionButton(onPressed: _sumar, child: const Icon(Icons.add)),
      ],
    );
  }


  void _sumar() {
    setState(() {
      _contador++;
    });
  }
  void _restar() {
    setState(() {
      _contador--;
    });
  }
  void _restart() {
    setState(() {
      _contador = 0;
    });
  }

}