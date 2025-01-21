import 'package:flutter/material.dart';
import 'package:qr_scan/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

/// Función utilitaria para manejar acciones según el tipo de scan.
/// Si es un enlace (http), lo abre en el navegador; si es una
/// ubicación (geo), navega a la pantalla del mapa.

void launchUrl(BuildContext context, ScanModel scan) async {
  final url = scan.valor;
  if (scan.tipus == 'http') {
    if (!await launch(url)) throw 'Could not launch $url';
  } else {
    Navigator.pushNamed(context, 'mapa', arguments: scan);
  }
}
