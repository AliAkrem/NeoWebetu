import 'package:sqflite/sqflite.dart';
import 'package:webtu_v2/DatabaseHelper/connection.dart';
import 'package:webtu_v2/DatabaseHelper/tables.dart';
import 'package:webtu_v2/models/assessment_notes.dart';

class AssessmentNotesRepository {
  final DatabaseHelper databaseHelper = DatabaseHelper();

  //Get AssessmentNotes //? SELECT * FROM AssessmentNotes limit 1
  Future<List<AssessmentNote>> getAssessmentNotes() async {
    final db = await databaseHelper.initDatabase();
    final List<Map<String, Object?>> assessmentNote =
        await db.query(Tables.AssessmentNotesTableName);

    return assessmentNote.map((json) => AssessmentNote.fromJson(json)).toList();
  }

  //? INSERT INTO AssessmentNotes
  Future<void> upsertAssessmentNotes(
      List<AssessmentNote> newAssessmentNotes) async {
    final db = await databaseHelper.initDatabase();

    for (var assessmentNote in newAssessmentNotes) {
      db.insert(Tables.AssessmentNotesTableName, assessmentNote.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }
}
