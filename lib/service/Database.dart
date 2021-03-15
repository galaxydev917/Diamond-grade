import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../model/report.dart';
import 'package:intl/intl.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "diamond_sort.db");
    String query = "CREATE TABLE 'tbl_gradehistory' (";
    query = query + "'id'	INTEGER,";
    query = query + "'createdAt'	TEXT,";
    query = query + "'weight'	TEXT,";
    query = query + "'colour'	TEXT,";
    query = query + "'clarity'	TEXT,";
    query = query + "'table_pct'	TEXT,";
    query = query + "'depth_pct'	TEXT,";
    query = query + "'crown_height'	TEXT,";
    query = query + "'crown_angle'	TEXT,";
    query = query + "'pavilion_depth'	TEXT,";
    query = query + "'pavilion_angle'	TEXT,";
    query = query + "'starface_length'	TEXT,";
    query = query + "'lower_half'	TEXT,";
    query = query + "'girdle'	TEXT,";
    query = query + "'culet'	TEXT,";
    query = query + "'grade'	TEXT,";
    query = query + "PRIMARY KEY('id' AUTOINCREMENT))";

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(query);
    });
  }

  Future<List<Report>> getAllReports() async {
    final db = await database;
    var res =
        await db.rawQuery("SELECT * FROM tbl_gradehistory ORDER BY id DESC");
    List<Report> reports =
        res.map((dynamic report) => Report.fromJson(report)).toList();

    return reports;
  }

  addReport(report) async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('d MMM yy H:mm').format(now);
    final db = await database;
    var raw = await db.rawInsert(
        "INSERT Into tbl_gradehistory (createdAt, weight, colour, clarity, table_pct, depth_pct, crown_height, crown_angle, pavilion_depth, pavilion_angle, starface_length, lower_half, girdle, culet, grade)"
        " VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
        [
          formattedDate,
          report['weight'],
          report['colour'],
          report['clarity'],
          report['table_pct'],
          report['depth_pct'],
          report['crown_height'],
          report['crown_angle'],
          report['pavilion_depth'],
          report['pavilion_angle'],
          report['starface:'],
          report['lower_half'],
          report['girdle'],
          report['culet'],
          report['grade']
        ]);
    return raw;
  }
}
