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
    Directory documentsDir = await getApplicationDocumentsDirectory();
    final path = join(documentsDir.path, 'Users.db');

    return await openDatabase(path, version: 1, onOpen: (db) {}, onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE Users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT UNIQUE,
            password TEXT
          )
        ''');
    });
  }

  Future<int> insertUser(String username, String password) async {
    final db = await database;
    final res = await db.insert(
      'Users',
      {'username': username, 'password': password},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return res;
  }

  Future<Map<String, dynamic>?> getUser(String username) async {
    final db = await database;
    final res = await db.query('Users', where: "username = ?", whereArgs: [username]);
    return res.isNotEmpty ? res.first : null;
  }

  Future<List<String>> getAllUsers() async {
    final db = await database;
    final res = await db.query('Users', columns: ['username']);
    return res.isNotEmpty ? res.map((u) => u['username'] as String).toList() : [];
  }
}
