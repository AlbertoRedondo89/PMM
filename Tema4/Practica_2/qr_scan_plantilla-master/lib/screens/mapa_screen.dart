import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_scan/models/scan_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Pantalla para mostrar un mapa interactivo usando Google Maps.
/// Permite centrar el mapa en la ubicación del scan y cambiar
/// entre diferentes tipos de mapas (normal, satélite, híbrido, etc.).

class MapaScreen extends StatefulWidget {
  const MapaScreen({Key? key}) : super(key: key);

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {
  Completer<GoogleMapController> _controller =
      Completer(); // Cmpleter es una especie de Future. Permite acceder al google maps antes de tenerlo como tal
  MapType _currentMapType = MapType.normal;
  @override
  Widget build(BuildContext context) {
    final ScanModel scan =
        ModalRoute.of(context)!.settings.arguments as ScanModel;
    final CameraPosition _puntiInicial = CameraPosition(
      target: scan.getLatLng(),
      zoom: 17,
      tilt: 70,
    );

    Set<Marker> markers = Set<Marker>();
    markers.add(Marker(
      position: scan.getLatLng(),
      markerId: MarkerId('Prueba'),
    ));

    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa'),
        actions: [
          IconButton(
            icon: Icon(Icons.center_focus_strong),
            onPressed: () async {
              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(
                CameraUpdate.newCameraPosition(_puntiInicial),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: _currentMapType,
            markers: markers,
            initialCameraPosition: _puntiInicial,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          Positioned(
            bottom: 20,
            left: MediaQuery.of(context).size.width / 2 -
                28, // Centrado horizontal
            child: FloatingActionButton(
              child: Icon(Icons.layers),
              onPressed: () {
                setState(() {
                  _currentMapType = _currentMapType == MapType.normal
                      ? MapType.satellite
                      : _currentMapType == MapType.satellite
                          ? MapType.hybrid
                          : _currentMapType == MapType.hybrid
                              ? MapType.terrain
                              : MapType.normal;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
