import 'package:flutter/material.dart';
import 'package:qr_scan/widgets/scan_tiles.dart';

/// Pantalla que muestra una lista de ubicaciones geográficas (geo)
/// escaneadas. Utiliza el widget `ScanTiles` para renderizar cada ubicación.

class MapasScreen extends StatelessWidget {
  const MapasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScanTiles(
        tipus: 'geo',
        backgroundColor: const Color.fromARGB(255, 105, 190, 230));
  }
}
