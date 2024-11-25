import 'package:flutter/material.dart';
import '../models/persona.dart';
import 'personal_page.dart';
import 'widget_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Persona persona = Persona(
    nom: "Nom",
    cognom: "Cognom",
    dataNaixement: "01/01/2000",
    correuElectronic: "example@example.com",
    contrasenya: "12345",
    puntuacio: "",
  );

  void _updatePersona(Persona updatedPersona) {
    setState(() {
      persona = updatedPersona;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2196F3), // Azul
              Color(0xFF90CAF9), // Azul claro
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [Padding(
                padding: const EdgeInsets.only(left: 20.0), // Añadimos margen a la izquierda
                child: const Text(
                  "Bienvenid a esta fantabulosa aplicación!",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InfoRow(label: "Nombre:", value: persona.nom),
                      InfoRow(label: "Apellido:", value: persona.cognom),
                      InfoRow(label: "Nacimiento:", value: persona.dataNaixement),
                      InfoRow(label: "Correo:", value: persona.correuElectronic),
                      InfoRow(
                        label: "Puntuación:",
                        value: (persona.puntuacio == null || persona.puntuacio!.isEmpty) 
                            ? "Sin puntuación" 
                            : persona.puntuacio!,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PersonalPage(persona: persona),
                    ),
                  );
                  if (result is Persona) {
                    _updatePersona(result);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Personal Page",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WidgetPage(persona: persona),
                    ),
                  );
                  if (result is Persona) {
                    _updatePersona(result);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Widget Page",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const InfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Text(
            "$label ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
