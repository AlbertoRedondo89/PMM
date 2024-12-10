import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practica_t3_hp/models/models.dart';
import 'package:practica_t3_hp/models/students_response.dart';

class CharactersProvider extends ChangeNotifier {
  final String _baseUrl = 'hp-api.onrender.com';
  final String _apiKey = '';
  final String _language = 'es-ES';
  final String _page = '1';

  List<StudentsResponse> estudiantes = [];

  CharactersProvider() {
    getStudents();
  }

  Future<void> getStudents() async {
    var url = Uri.https(_baseUrl, '/api/characters/students');
    final result = await http.get(url);
    if (result.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(result.body);

      // Parsear la lista de estudiantes
      estudiantes =
          jsonData.map((student) => StudentsResponse.fromMap(student)).toList();

      notifyListeners();
    } else {
      throw Exception('Failed to load students');
    }
  }
}
