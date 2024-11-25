import 'package:flutter/material.dart';
import 'package:practica/widgets/InfoRow.dart';
import '../models/persona.dart';
import 'personal_page.dart';
import 'widget_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Instancia de la clase persona que se muestra
  Persona persona = Persona(
    nom: "Nom",
    cognom: "Cognom",
    dataNaixement: "01/01/2000",
    correuElectronic: "example@example.com",
    contrasenya: "12345",
    puntuacio: "",
  );

  // Método para actualizar los datos de persona
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
              // ------------------------------------------------------------------ INFO PERSONA
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
              // ----------------------------------------------------------------------- BOTONES
                                                                                      // BOTON 1
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
                                                                         // ESTILO

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
                                                                                      // BOTON 2
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
                                                                            // ESTILO
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
