import 'package:webtu_v2/DatabaseHelper/connection.dart';
import 'package:webtu_v2/DatabaseHelper/tables.dart';
import 'package:webtu_v2/models/student.dart';

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
  Future<int> addStudent(Student Student) async {
    //clear existing student
    await deleteStudent();

    // add new one
    final db = await databaseHelper.initDatabase();
    return db.insert(Tables.StudentTableName, Student.toJson());
  }

  //  Update Student //? UPDATE WHERE id = ?
  Future<int> updateStudent(Student Student) async {
    final db = await databaseHelper.initDatabase();
    return db.update(Tables.StudentTableName, Student.toJson(),
        where: "id = ?", whereArgs: [Student.id]);
  }

  //Delete Student //? DELETE from Student
  Future<int> deleteStudent() async {
    final db = await databaseHelper.initDatabase();
    return db.delete(Tables.StudentTableName);
  }
}
