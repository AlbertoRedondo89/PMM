import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static Database? _database;
  static final DatabaseHelper db = DatabaseHelper._();

  DatabaseHelper._();

  Future<Database> get database async {
    if (_database == null) _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    Directory documentsDir = await getApplicationDocumentsDirectory();
    final path = join(documentsDir.path, 'users.db');

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

  Future<int> insertUser(String username, String password) async {
    final db = await database;
    return await db.insert('Users', {
      'username': username,
      'password': password,
    });
  }

  Future<Map<String, dynamic>?> getUser(String username) async {
    final db = await database;
    final res = await db.query('Users', where: "username = ?", whereArgs: [username]);

    if (res.isNotEmpty) {
      return res.first;
    } else {
      return null;
    }
  }
}
