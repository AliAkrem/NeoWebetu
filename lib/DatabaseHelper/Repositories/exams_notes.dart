import 'package:sqflite/sqflite.dart';
import 'package:neowebetu/DatabaseHelper/connection.dart';
import 'package:neowebetu/DatabaseHelper/tables.dart';
import 'package:neowebetu/models/exam_notes.dart';

class ExamsNotesRepository {
  final DatabaseHelper databaseHelper = DatabaseHelper();

  //Get ExamsNotes //? SELECT * FROM ExamsNotes limit 1
  Future<List<ExamNotes>?> getExamsNotes() async {
    final db = await databaseHelper.initDatabase();
    final List<Map<String, Object?>> examNotes =
        await db.query(Tables.ExamTableName);

    if (examNotes.isNotEmpty) {
      return examNotes.map((json) => ExamNotes.fromJson(json)).toList();
    } else {
      return null;
    }
  }

  // Add Student //? INSERT INTO ExamNotes
  Future<void> upsertExamsNotes(List<ExamNotes> newExamsNotes) async {
    final db = await databaseHelper.initDatabase();

    final batch = db.batch();

    for (var examNote in newExamsNotes) {
      batch.insert(Tables.ExamTableName, examNote.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }

    await batch.commit();
  }
}
