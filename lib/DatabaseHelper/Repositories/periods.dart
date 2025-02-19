import 'package:webtu_v2/DatabaseHelper/connection.dart';
import 'package:webtu_v2/DatabaseHelper/tables.dart';
import 'package:webtu_v2/models/period.dart';

class PeriodRepository {
  final DatabaseHelper databaseHelper = DatabaseHelper();

  //Get Period //? SELECT * FROM Period limit 1
  Future<List<Period>> getPeriod() async {
    final db = await databaseHelper.initDatabase();
    final List<Map<String, Object?>> periods =
        await db.query(Tables.PeriodTableName);

    return periods.map((period) => Period.fromJson(period)).toList();
  }

  //Get Period by ID //? SELECT * FROM Period WHERE id = ?
  Future<Period?> getPeriodById(int id) async {
    final db = await databaseHelper.initDatabase();
    final List<Map<String, Object?>> periods = await db.query(
      Tables.PeriodTableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (periods.isEmpty) return null;
    return Period.fromJson(periods.first);
  }


  // Add Period //? INSERT INTO Period
  Future<int> addPeriods(List<Period> periods) async {
    // add new one
    final db = await databaseHelper.initDatabase();
    int count = 0;

    for (var period in periods) {
      count += await db.insert(Tables.PeriodTableName, period.toJson());
    }
    return count;
  }

  //  Update Period //? UPDATE WHERE id = ?
  Future<int> updatePeriod(Period period) async {
    final db = await databaseHelper.initDatabase();
    return db.update(Tables.PeriodTableName, period.toJson(),
        where: "id = ?", whereArgs: [period.id]);
  }

  //Delete Period //? DELETE from Period
  Future<int> deletePeriod() async {
    final db = await databaseHelper.initDatabase();
    return db.delete(Tables.PeriodTableName);
  }
}
