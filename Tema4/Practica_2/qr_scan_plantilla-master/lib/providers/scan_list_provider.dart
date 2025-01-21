import 'package:flutter/material.dart';
import 'package:qr_scan/models/scan_model.dart';
import 'package:qr_scan/providers/db_provider.dart';

/// Proveedor que gestiona el estado de la lista de scans.
/// Permite cargar, eliminar, renombrar y crear nuevos scans,
/// y notifica a los listeners cuando hay cambios para actualizar la UI.

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String tipusSeleccionat = 'http';

  Future<ScanModel> nouScan(String valor) async {
    final nouScan = ScanModel(valor: valor);
    final id = await DbProvider.db.insertScan(nouScan);
    nouScan.id = id;

    if (nouScan.tipus == tipusSeleccionat) {
      this.scans.add(nouScan);
      notifyListeners();
    }

    return nouScan;
  }

  carregaScans() async {
    final scans = await DbProvider.db.getAllScans();
    this.scans = [...scans]; //spread operator (añade elementos a una lista)
    notifyListeners();
  }

  carregaScansPerTipus(String tipus) async {
    final scans = await DbProvider.db.getScansByTipus(tipus);
    this.scans = [...scans!];
    this.tipusSeleccionat = tipus;
    notifyListeners();
  }

  esborraTots() async {
    final scans = await DbProvider.db.deleteAllScans();
    this.scans = [];
    notifyListeners();
  }

  esborraPerId(int id) async {
    final scans = await DbProvider.db.deleteScanById(id);
  }

  renombrarPerId(int id, String nouNom) async {
    await DbProvider.db.updateScanNouNom(id, nouNom);
    scans = scans.map((scan) {
      if (scan.id == id) {
        scan.nombre = nouNom;
      }
      return scan;
    }).toList();
    notifyListeners();
  }
}
