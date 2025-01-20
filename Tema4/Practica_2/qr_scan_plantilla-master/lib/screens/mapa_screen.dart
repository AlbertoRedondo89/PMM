import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_scan/models/scan_model.dart';
import 'package:qr_scan/widgets/scan_tiles.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaScreen extends StatefulWidget {
  const MapaScreen({Key? key}) : super(key: key);

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {
  Completer<GoogleMapController> _controller =
      Completer(); // Cmpleter es una especie de Future. Permite acceder al google maps antes de tenerlo como tal
  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context)!.settings.arguments
        as ScanModel; // ------------------------------------------!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    final CameraPosition _puntiInicial = CameraPosition(
      target: scan.getLatLng(),
      zoom: 17,
      tilt: 70,
    );

    Set<Marker> markers = new Set<Marker>();
    markers.add(new Marker(
      position: scan.getLatLng(),
      markerId: MarkerId('Prueba'),
    ));

    /*
    Añadir AppBar para volver atras, con un icono para centrar
    un icono para cambiar el tipo de mapa
    */

    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        markers: markers,
        initialCameraPosition: _puntiInicial,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
