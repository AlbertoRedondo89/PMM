import 'package:flutter/material.dart';
import '../models/persona.dart';

class PersonalPage extends StatefulWidget {
  final Persona persona;

  const PersonalPage({super.key, required this.persona});

  @override
  _PersonalPageState createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  late TextEditingController _nomController;
  late TextEditingController _cognomController;
  late TextEditingController _dataController;
  late TextEditingController _correuController;
  late TextEditingController _contrasenyaController;

  @override
  void initState() {
    super.initState();
    _nomController = TextEditingController(text: widget.persona.nom);
    _cognomController = TextEditingController(text: widget.persona.cognom);
    _dataController = TextEditingController(text: widget.persona.dataNaixement);
    _correuController = TextEditingController(text: widget.persona.correuElectronic);
    _contrasenyaController = TextEditingController(text: widget.persona.contrasenya);
  }

  @override
  void dispose() {
    _nomController.dispose();
    _cognomController.dispose();
    _dataController.dispose();
    _correuController.dispose();
    _contrasenyaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.persona.cognom),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nomController,
              decoration: const InputDecoration(labelText: "Nom"),
            ),
            TextField(
              controller: _cognomController,
              decoration: const InputDecoration(labelText: "Cognom"),
            ),
            TextField(
              controller: _dataController,
              decoration: const InputDecoration(labelText: "Data de Naixement"),
            ),
            TextField(
              controller: _correuController,
              decoration: const InputDecoration(labelText: "Correu Electrònic"),
            ),
            TextField(
              controller: _contrasenyaController,
              decoration: const InputDecoration(labelText: "Contrasenya"),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final updatedPersona = Persona(
                  nom: _nomController.text,
                  cognom: _cognomController.text,
                  dataNaixement: _dataController.text,
                  correuElectronic: _correuController.text,
                  contrasenya: _contrasenyaController.text,
                  puntuacio: widget.persona.puntuacio,
                );
                Navigator.pop(context, updatedPersona);
              },
              child: const Text("Desa"),
            ),
          ],
        ),
      ),
    );
  }
}
