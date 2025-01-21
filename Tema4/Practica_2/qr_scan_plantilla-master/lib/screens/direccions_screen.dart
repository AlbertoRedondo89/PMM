import 'package:flutter/material.dart';
import 'package:qr_scan/widgets/scan_tiles.dart';

/// Pantalla que muestra una lista de direcciones (http) escaneadas.
/// Utiliza el widget `ScanTiles` para renderizar cada dirección.

class DireccionsScreen extends StatelessWidget {
  const DireccionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScanTiles(
      tipus: 'http',
      backgroundColor: const Color.fromARGB(255, 255, 212, 83),
    );
  }
}
