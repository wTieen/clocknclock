import 'dart:async';
import 'package:clocknclock/util/alarm_tile.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';



class DatabaseHelper_alarm_list {
  static final DatabaseHelper_alarm_list instance = DatabaseHelper_alarm_list._privateConstructor();
  static Database? _database;

  DatabaseHelper_alarm_list._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'alarm_new_database.db');
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE alarm_table(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        alarmName TEXT,
        alarmTime TEXT,
        alarmStatus INTEGER
      )
    ''');
  }
  Future<int> insertAlarm(AlarmTile alarm) async {
    try {
      Database db = await instance.database;

      print("Inserting alarm_table: ${alarm.toMap()}");

      int result = await db.insert('alarm_table', alarm.toMap());

      print("Insert result: $result");

      return result;
    } catch (e) {
      print("Error inserting alarm_table: $e");
      return -1; // Trả về giá trị âm để báo lỗi
    }
  }
  // Bằng cách này, bạn có thể xem thông điệp từ các dòng log và xác định nguyên nhân gây ra vấn đề.

  Future<List<AlarmTile>> getAllAlarms() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query('alarm_table');
    return List.generate(maps.length, (index) {
      return AlarmTile.fromMap(maps[index]);
    });
  }

  Future<int> updateAlarm(AlarmTile alarm) async {
    Database db = await instance.database;
    return await db.update('alarm_table', alarm.toMap(),
        where: 'id = ?', whereArgs: [alarm.id]);
  }

  Future<int> deleteAlarm(int? id) async {
    Database db = await instance.database;
    return await db.delete('alarm_table', where: 'id = ?', whereArgs: [id]);
  }
}
