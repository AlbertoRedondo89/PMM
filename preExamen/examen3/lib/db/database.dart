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

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE Users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT UNIQUE,
            password TEXT
          )
        ''');
      },
    );
  }

  // Insertar usuario
  Future<int> insertUser(String username, String password) async {
    final db = await database;

    // Verificar si el usuario ya existe
    bool exists = await userExists(username);
    if (exists) {
      throw Exception("El usuario ya existe");
    }

    // Insertar usuario
    final res = await db.insert('Users', {
      'username': username,
      'password': password
    });

    return res;
  }


  // Obtener todos los usuarios
  Future<List<Map<String, dynamic>>> getAllUsers() async {
    final db = await database;
    return await db.query('Users');
  }

  // Obtener usuario por nombre
  Future<Map<String, dynamic>?> getUserByUsername(String username) async {
    final db = await database;
    final res = await db.query('Users', where: "username = ?", whereArgs: [username]);
    return res.isNotEmpty ? res.first : null;
  }

  // Actualizar usuario
  Future<int> updateUser(int id, String newPassword) async {
    final db = await database;
    return await db.update('Users', {'password': newPassword}, where: "id = ?", whereArgs: [id]);
  }

  // Eliminar usuario
  Future<int> deleteUser(int id) async {
    final db = await database;
    return await db.delete('Users', where: "id = ?", whereArgs: [id]);
  }

  Future<bool> userExists(String username) async {
    final db = await database;
    final res = await db.query(
      'Users', 
      where: "username = ?", 
      whereArgs: [username]
    );
    return res.isNotEmpty;
  }

}
