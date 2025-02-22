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

  /// **CREATE - Insertar usuario**
  Future<int> insertUser(String username, String password) async {
    final db = await database;
    final res = await db.insert(
      'Users',
      {'username': username, 'password': password},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return res;
  }

  /// **READ - Obtener usuario por nombre**
  Future<Map<String, dynamic>?> getUser(String username) async {
    final db = await database;
    final res = await db.query('Users', where: "username = ?", whereArgs: [username]);
    return res.isNotEmpty ? res.first : null;
  }

  /// **READ - Obtener todos los usuarios**
  Future<List<Map<String, dynamic>>> getAllUsers() async {
    final db = await database;
    final res = await db.query('Users');
    return res;
  }

  /// **UPDATE - Cambiar contraseña de usuario**
  Future<int> updateUser(String username, String newPassword) async {
    final db = await database;
    final res = await db.update(
      'Users',
      {'password': newPassword},
      where: 'username = ?',
      whereArgs: [username],
    );
    return res;
  }

  /// **DELETE - Eliminar usuario**
  Future<int> deleteUser(String username) async {
    final db = await database;
    final res = await db.delete('Users', where: 'username = ?', whereArgs: [username]);
    return res;
  }
}
