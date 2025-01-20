import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

class ScanModel {
  ScanModel({
    this.id,
    this.tipus,
    required this.valor,
  }) {
    if (this.valor.contains('http')) {
      this.tipus = 'http';
    } else
      this.tipus = 'geo';
  }

  int? id;
  String? tipus;
  String valor;

  LatLng getLatLng() {
    try {
      // Verifica si el valor tiene la longitud mínima requerida para hacer substring(4)
      if (this.valor.length <= 4) {
        throw RangeError(
            'El valor no tiene suficiente longitud para hacer substring(4)');
      }

      // Obtén el substring desde el índice 4
      final latlng = this.valor.substring(4).split(',');

      // Verifica que el resultado del split tenga al menos dos elementos
      if (latlng.length != 2) {
        throw FormatException(
            'El valor no tiene el formato esperado: "lat,lng"');
      }

      // Intenta convertir las coordenadas a double
      final latitud = double.parse(latlng[0]);
      final longitud = double.parse(latlng[1]);

      return LatLng(latitud, longitud);
    } catch (e) {
      // Maneja errores y devuelve un valor predeterminado
      print('Error en getLatLng: $e');
      return LatLng(0.0, 0.0); // Coordenadas predeterminadas
    }
  }

  factory ScanModel.fromJson(String str) => ScanModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ScanModel.fromMap(Map<String, dynamic> json) => ScanModel(
        id: json["id"],
        tipus: json["tipus"],
        valor: json["valor"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "tipus": tipus,
        "valor": valor,
      };
}
