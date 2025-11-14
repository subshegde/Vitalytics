import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:vitalytics/data/models/disease_detection/disease_detection_model.dart';
import 'db_helper.dart';

class DiseaseDetectionDao {
  static const String tableName = 'disease_detection';

  // INSERT
  Future<int> insertDisease(DiseaseDetectionModel disease, int userId) async {
    final db = await DBHelper.instance.database;

    return await db.insert(
      tableName,
      {
        'user_id': userId,
        'detected_disease': disease.detected_disease,
        'confidence_score': disease.confidence_score,
        'description': disease.description,
        'precautionary_steps': jsonEncode(disease.precautionary_steps),
        'created_at': DateTime.now().toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // GET for a specific user
  Future<List<DiseaseDetectionModel>> getDiseasesByUser(int userId) async {
    final db = await DBHelper.instance.database;

    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'user_id = ?',
      whereArgs: [userId],
      orderBy: 'created_at DESC',
    );

    return maps.map((map) {
      return DiseaseDetectionModel(
        detected_disease: map['detected_disease'],
        confidence_score: map['confidence_score'],
        description: map['description'],
        precautionary_steps: List<String>.from(
          jsonDecode(map['precautionary_steps']),
        ),
      );
    }).toList();
  }

  // DELETE single record
  Future<int> deleteDisease(int id) async {
    final db = await DBHelper.instance.database;
    return await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  // DELETE ALL
  Future<int> deleteAllDiseases() async {
    final db = await DBHelper.instance.database;
    return await db.delete(tableName);
  }
}