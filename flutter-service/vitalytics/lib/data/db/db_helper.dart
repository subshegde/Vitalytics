import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static const _dbName = 'vitalytics.db';
  static const _dbVersion = 1;

  DBHelper._privateConstructor();
  static final DBHelper instance = DBHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _dbName);

    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL,
        bio TEXT,
        profile_pic_path TEXT
      )
    ''');

    // Seed default user
    await db.insert('users', {
      'username': 'Test User',
      'email': 'test@example.com',
      'password': '123456',     // FIXED: password added
      'bio': 'This is a test user',
      'profile_pic_path': null,
    });
  }

  // Raw helpers
  Future<int> rawInsert(String sql, [List<Object?>? args]) async {
    final db = await database;
    return await db.rawInsert(sql, args);
  }

  Future<List<Map<String, dynamic>>> rawQuery(String sql,
      [List<Object?>? args]) async {
    final db = await database;
    return await db.rawQuery(sql, args);
  }
}