import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:webtu_v2/DatabaseHelper/tables.dart';

class DatabaseHelper {
  final databaseName = "app.db";

  Future<Database> initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);
    return openDatabase(path, version: 1, onCreate: (db, version) async {
      //inital tables
      await db.execute(Tables.StudentTable);
      
    });
  }
}