import 'package:flutter/material.dart';
import 'package:qr_scan/models/scan_model.dart';
import 'package:qr_scan/providers/db_provider.dart';

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

  // TODO:

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
    // ?????????
  }
}
