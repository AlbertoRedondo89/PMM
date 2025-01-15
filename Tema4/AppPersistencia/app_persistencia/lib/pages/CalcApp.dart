import 'package:app_persistencia/provider/CalcProvider.dart';
import 'package:app_persistencia/widgets/CalcButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class CalcApp extends StatelessWidget {
  const CalcApp({super.key});

  @override
  Widget build(BuildContext context) {
    final calcProvider = Provider.of<CalcProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF2283637),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              alignment: const Alignment(1.0, 1.0),
              child: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Text(
                  calcProvider.historial,
                  style: GoogleFonts.rubik(
                      textStyle:
                          const TextStyle(fontSize: 24, color: Color(0xFF545F61))),
                ),
              ),
            ),
            Container(
              alignment: const Alignment(1.0, 1.0),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  calcProvider.expresion,
                  style: GoogleFonts.rubik(
                      textStyle: const TextStyle(fontSize: 48, color: Colors.white)),
                ),
              ),
            ),
            _buildButtonRows(calcProvider),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonRows(CalcProvider calcProvider) {
    final List<List<Map<String, dynamic>>> botones = [
      [
        {'text': 'AC', 'bgColor': 0xFF00BF45, 'callback': calcProvider.allClear},
        {'text': 'C', 'bgColor': 0xFFE3303A, 'callback': calcProvider.clear},
        {'text': '%', 'callback': calcProvider.numClick},
        {'text': '/', 'callback': calcProvider.numClick},
      ],
      [
        {'text': '7', 'callback': calcProvider.numClick},
        {'text': '8', 'callback': calcProvider.numClick},
        {'text': '9', 'callback': calcProvider.numClick},
        {'text': '*', 'callback': calcProvider.numClick},
      ],
      [
        {'text': '4', 'callback': calcProvider.numClick},
        {'text': '5', 'callback': calcProvider.numClick},
        {'text': '6', 'callback': calcProvider.numClick},
        {'text': '-', 'callback': calcProvider.numClick},
      ],
      [
        {'text': '1', 'callback': calcProvider.numClick},
        {'text': '2', 'callback': calcProvider.numClick},
        {'text': '3', 'callback': calcProvider.numClick},
        {'text': '+', 'callback': calcProvider.numClick},
      ],
      [
        {'text': '.', 'callback': calcProvider.numClick},
        {'text': '0', 'callback': calcProvider.numClick},
        {'text': '00', 'callback': calcProvider.numClick},
        {'text': '=', 'callback': calcProvider.evaluar},
      ],
    ];

    return Column(
      children: botones.map((row) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: row.map((button) {
            return Calcbutton(
              text: button['text'],
              bgColor: button['bgColor'] ?? 0xFF3E3E3E,
              textSize: 20,
              callBack: (String text) => button['callback']!(text),
            );
          }).toList(),
        );
      }).toList(),
    );
  }
}
