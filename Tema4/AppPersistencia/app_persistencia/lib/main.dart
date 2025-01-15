import 'package:app_persistencia/pages/CalcApp.dart';
import 'package:app_persistencia/provider/CalcProvider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CalcProvider(),
        ),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora',
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => const CalcApp(),
      },
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(
          color: Color.fromARGB(255, 189, 129, 80),
        ),
      ),
    );
  }
}

/*
class CalcApp extends StatefulWidget {
  const CalcApp({super.key});

  @override
  State<CalcApp> createState() => _CalcAppState();
}

class _CalcAppState extends State<CalcApp> {
  String _historial = "";
  String _expresion = "";
  void allClear(String text) {
    setState(() {
      _historial = "";
      _expresion = "";
    });
  }
  void clear(String text) {
    setState(() {
      _expresion = "";
    });
  }
void evaluar(String datos){
  Parser p = Parser();
  Expression exp = p.parse(_expresion);
  ContextModel cm = ContextModel();
  setState(() {
    _historial = _expresion;
    _expresion = exp.evaluate(EvaluationType.REAL, cm).toString();

  });
}
void numClick(String text) {
  setState(() {
    _expresion += text;
  });
}

  @override
  Widget build(BuildContext context) {
    // Definimos los botones por filas
    List<List<Map<String, dynamic>>> botones = [
      [
        {'text': 'AC', 'bgColor': 0xFF00BF45, 'callback': allClear},
        {'text': 'C', 'bgColor': 0xFFE3303A, 'callback': clear},
        {'text': '%', 'callback': numClick},
        {'text': '/', 'callback': numClick},
      ],
      [
        {'text': '7', 'callback': numClick},
        {'text': '8', 'callback': numClick},
        {'text': '9', 'callback': numClick},
        {'text': '*', 'callback': numClick},
      ],
      [
        {'text': '4', 'callback': numClick},
        {'text': '5', 'callback': numClick},
        {'text': '6', 'callback': numClick},
        {'text': '-', 'callback': numClick},
      ],
      [
        {'text': '1', 'callback': numClick},
        {'text': '2', 'callback': numClick},
        {'text': '3', 'callback': numClick},
        {'text': '+', 'callback': numClick},
      ],
      [
        {'text': '.', 'callback': numClick},
        {'text': '0', 'callback': numClick},
        {'text': '00', 'callback': numClick},
        {'text': '=', 'callback': evaluar},
      ],
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Calculadora",
      home: Scaffold(
        backgroundColor: const Color(0xFF2283637),
        body: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              // Pantalla de historial
              Container(
                alignment: const Alignment(1.0, 1.0),
                child: Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Text(
                    _historial,
                    style: GoogleFonts.rubik(
                      textStyle: const TextStyle(
                        fontSize: 24,
                        color: Color(0xFF545F61),
                      ),
                    ),
                  ),
                ),
              ),
              // Pantalla de expresión actual
              Container(
                alignment: const Alignment(1.0, 1.0),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    _expresion,
                    style: GoogleFonts.rubik(
                      textStyle: const TextStyle(
                        fontSize: 48,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              // Generación dinámica de filas de botones
              ...botones.map(
                (fila) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: fila.map((boton) {
                    return Calcbutton(
                      text: boton['text'],
                      callBack: boton['callback'],
                      bgColor: boton.containsKey('bgColor')
                          ? boton['bgColor']
                          : 0xFF1D1E33,
                      textSize: 20,
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/