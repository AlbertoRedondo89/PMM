import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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
          valor TEXT
        )
        ''');
    });
  }
}
