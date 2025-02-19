import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:webtu_v2/DatabaseHelper/tables.dart';

class DatabaseHelper {
  final databaseName = "app6.db";

  Future<Database> initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);
    return openDatabase(path, version: 2, onCreate: (db, version) async {
      await db.execute(Tables.StudentTable);
      await db.execute(Tables.ExamNoteTable);
      await db.execute(Tables.PeriodTable);
    });
  }
}
