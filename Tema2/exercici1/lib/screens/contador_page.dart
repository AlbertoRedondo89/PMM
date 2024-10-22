import 'package:flutter/widgets.dart';
import 'package:exercici1/screens/contador_page.dart';
import 'package:exercici1/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ContadorPage extends StatefulWidget{

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
final _estil = TextStyle(fontSize: 24);

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contador amb Stateful'),
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
        SizedBox(width: 30.0,),
        FloatingActionButton(child: Icon(Icons.exposure_zero) ,onPressed: _restart),
        Expanded(child: SizedBox()),
        FloatingActionButton(child: Icon(Icons.remove) ,onPressed: _restar),
        SizedBox(width: 5.0),
        FloatingActionButton(child: Icon(Icons.add) ,onPressed: _sumar),
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