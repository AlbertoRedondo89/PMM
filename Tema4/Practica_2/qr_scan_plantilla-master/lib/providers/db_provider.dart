import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:qr_scan/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/// Proveedor para manejar la base de datos SQLite de la aplicación.
/// Permite inicializar la base de datos, realizar operaciones CRUD,
/// y gestionar los datos almacenados en la tabla "Scans".

class DbProvider {
  static Database? _database;
  static final DbProvider db = DbProvider._();

  DbProvider._();

  Future<Database> get database async {
    if (_database == null) _database = await initDB();

    return _database!;
  }

  Future<Database> initDB() async {
    //obtener path
    Directory documentsDir = await getApplicationDocumentsDirectory();
    final path = join(documentsDir.path, 'Scans.db');
    print(path);

    //creacion db
    return await openDatabase(path,
        version: 1, //si version no cambia, devolverá la misma DB
        onOpen: (db) {}, onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY,
            tipus TEXT,
            valor TEXT,
            nombre TEXT
          )
        ''');
    });
  }

// 1 forma hacer INSERT
  Future<int> insertRawScan(ScanModel nouScan) async {
    final id = nouScan.id;
    final tipus = nouScan.tipus;
    final valor = nouScan.valor;

    final db = await database;

    final res = await db.rawInsert('''
      INSERT INTO Scans(id, tipus, valor)
        VALUES ($id, $tipus, $valor)
    ''');
    return res;
  }

  //2 FORMA
  Future<int> insertScan(ScanModel nouScan) async {
    final db = await database;

    final res = await db.insert('Scans', nouScan.toMap());

    print(res);
    return res;
  }

// SELECTS
  Future<List<ScanModel>> getAllScans() async {
    final db = await database;
    final res = await db
        .query('Scans'); //Indicamos la tabla y ya devuelve todas sus filas
    //si la tabla no esta vacia trataremos cada fila con el método fromMap y después pasarlo a lista. Si no, lista vacía
    return res.isNotEmpty ? res.map((e) => ScanModel.fromMap(e)).toList() : [];
  }

  Future<ScanModel?> getScanById(int id) async {
    final db = await database;
    final res = await db.query('Scans', where: "id = ?", whereArgs: [id]);

    if (res.isNotEmpty)
      return ScanModel.fromMap(res.first);
    else
      return null;
  }

  Future<List<ScanModel>> getScansByTipus(String tipus) async {
    final db = await database;
    final res = await db.query('Scans', where: 'tipus = ?', whereArgs: [tipus]);
    return res.isNotEmpty ? res.map((e) => ScanModel.fromMap(e)).toList() : [];
  }

  // Por hacer: recibe un Styring tipus y devuelve lista

  Future<int> updateScan(ScanModel nouScan) async {
    final db = await database;
    final res = db.update('Scans', nouScan.toMap(),
        where: 'id = ?', whereArgs: [nouScan.id]);

    return res;
  }

  // DELETE ALL, falta implementar el DELETE SCAN en funcion del id
  Future<int> deleteAllScans() async {
    final db = await database;
    final res = await db.rawDelete('''
      DELETE FROM Scans
    ''');
    return res;
  }

  Future<int> deleteScanById(int id) async {
    final db = await database;
    final res = db.delete('Scans', where: 'id = ?', whereArgs: [id]);

    return res;
  }

  Future<int> updateScanNouNom(int id, String nouNom) async {
    final db = await database;
    final res = db.update('Scans', {'nombre': nouNom},
        where: 'id = ?', whereArgs: [id]);

    return res;
  }
}
