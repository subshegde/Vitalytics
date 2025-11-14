import 'package:sqflite/sqflite.dart';
import 'package:vitalytics/data/models/user/user.dart';
import '../db/db_helper.dart';

class UserDao {
  final DBHelper _dbHelper = DBHelper.instance;

  // Insert user
  Future<int> insertUser(User user) async {
    final db = await _dbHelper.database;
    return await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Get by ID
  Future<User?> getUserById(int id) async {
    final db = await _dbHelper.database;
    final maps = await db.query('users', where: 'id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) return User.fromMap(maps.first);
    return null;
  }

  // Get by email
  Future<User?> getUserByEmail(String email) async {
    final db = await _dbHelper.database;
    final maps = await db.query('users', where: 'email = ?', whereArgs: [email]);
    if (maps.isNotEmpty) return User.fromMap(maps.first);
    return null;
  }

  // Get by username
  Future<User?> getUserByUsername(String username) async {
    final db = await _dbHelper.database;
    final maps =
        await db.query('users', where: 'username = ?', whereArgs: [username]);
    if (maps.isNotEmpty) return User.fromMap(maps.first);
    return null;
  }

  // Get by email OR username
  Future<User?> getUserByEmailOrUsername(String input) async {
    final db = await _dbHelper.database;
    final maps = await db.query(
      'users',
      where: 'email = ? OR username = ?',
      whereArgs: [input, input],
    );
    if (maps.isNotEmpty) return User.fromMap(maps.first);
    return null;
  }

  // Get all
  Future<List<User>> getAllUsers() async {
    final db = await _dbHelper.database;
    final maps = await db.query('users');
    return maps.map((m) => User.fromMap(m)).toList();
  }

  // Update
  Future<int> updateUser(User user) async {
    final db = await _dbHelper.database;
    return await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  // Delete
  Future<int> deleteUser(int id) async {
    final db = await _dbHelper.database;
    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  // Update profile picture
  Future<int> updateProfilePicturePath(int userId, String path) async {
    final db = await _dbHelper.database;
    return await db.update(
      'users',
      {'profile_pic_path': path},
      where: 'id = ?',
      whereArgs: [userId],
    );
  }

  // Get profile detail
  Future<User?> getProfileDetail(int userId) async {
    return await getUserById(userId);
  }
}