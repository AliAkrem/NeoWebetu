import 'package:neowebetu/DatabaseHelper/connection.dart';
import 'package:neowebetu/DatabaseHelper/tables.dart';
import 'package:neowebetu/models/student.dart';

class StudentRepository {
  final DatabaseHelper databaseHelper = DatabaseHelper();

  //Get Student //? SELECT * FROM Student limit 1
  Future<Student?> getStudent() async {
    final db = await databaseHelper.initDatabase();
    final List<Map<String, Object?>> student =
        await db.query(Tables.StudentTableName, limit: 1);
    if (student.isNotEmpty) {
      return Student.fromJson(student.first);
    } else {
      return null;
    }
  }

  // Add Student //? INSERT INTO Student
  Future<int> addStudent(Student student) async {
    // add new one
    final db = await databaseHelper.initDatabase();
    return db.insert(Tables.StudentTableName, student.toJson());
  }

  //  Update Student //? UPDATE WHERE id = ?
  Future<int> updateStudent(Student student) async {
    final db = await databaseHelper.initDatabase();
    return db.update(Tables.StudentTableName, student.toJson(),
        where: "id = ?", whereArgs: [student.id]);
  }

  //Delete Student //? DELETE from Student
  Future<void> deleteStudent() async {
    final db = await databaseHelper.initDatabase();

    await db.delete(Tables.StudentTableName);
    await db.delete(Tables.ExamTableName);
    await db.delete(Tables.PeriodTableName);
    await db.delete(Tables.AssessmentNotesTableName);
  }
}
