import 'package:flutter/material.dart';
import 'package:practica/models/persona.dart';
import 'package:practica/screens/VideoScroller.dart';
import 'package:practica/widgets/VideoPlayerScreen.dart';
import 'package:practica/widgets/customratingbar.dart';

class WidgetPage extends StatefulWidget {
  final Persona persona;

  const WidgetPage({super.key, required this.persona});
  
  @override
  State<WidgetPage> createState() => _WidgetPageState();
}

class _WidgetPageState extends State<WidgetPage> {
  final List<String> valoracions = ["Terrible", "Malísimo", "Muy mal", "Mal", "Regular", "Suficiente", "Bien", "Muy bien", "Genial", "Digno de Alberto"];
  String ?puntuacio = "Valoració";

 @override
  void initState() {
    super.initState();
    puntuacio = widget.persona.puntuacio!.isEmpty ? "Valoració" : widget.persona.puntuacio;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WidgetPage"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(puntuacio!),
            CustomRatingBar(
              initialRating: 3,
              onRatingUpdate: (rating) {
                setState(() {
                  cambiaValor(rating);
                });
              },
            ),
            const Divider(),
            ElevatedButton(
              onPressed: () {
                widget.persona.puntuacio = puntuacio;
                Navigator.pop(context, widget.persona);
              },
              child: const Icon(Icons.abc_sharp)),
            Tooltip(
              message: "Això és un Tooltip",
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("Prem-me!"),
              ),
            ),
            const Divider(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,  MaterialPageRoute(
                  builder: (context) => VideoScroller(), // Navega al reproductor de video
                ),
              );
            },
            child: const Text("VIDEO"),
            ),
            
          ],
        ),
      ),
    );
  }

  void cambiaValor(double i) {
    puntuacio = valoracions[i.toInt()-1];
  }
}
