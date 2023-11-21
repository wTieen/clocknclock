import 'dart:async';
import 'package:clocknclock/util/alarm_tile.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';



class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'task_new_database.db');
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE task_table(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        taskName TEXT,
        taskTime TEXT,
        taskStatus INTEGER
      )
    ''');
  }
  Future<int> insertTask(AlarmTile task) async {
    try {
      Database db = await instance.database;

      print("Inserting task_table: ${task.toMap()}");

      int result = await db.insert('task_table', task.toMap());

      print("Insert result: $result");

      return result;
    } catch (e) {
      print("Error inserting task_table: $e");
      return -1; // Trả về giá trị âm để báo lỗi
    }
  }
  // Bằng cách này, bạn có thể xem thông điệp từ các dòng log và xác định nguyên nhân gây ra vấn đề.

  Future<List<AlarmTile>> getAllTasks() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query('task_table');
    return List.generate(maps.length, (index) {
      return AlarmTile.fromMap(maps[index]);
    });
  }

  Future<int> updateTask(AlarmTile task) async {
    Database db = await instance.database;
    return await db.update('task_table', task.toMap(),
        where: 'id = ?', whereArgs: [task.id]);
  }

  Future<int> deleteTask(int? id) async {
    Database db = await instance.database;
    return await db.delete('task_table', where: 'id = ?', whereArgs: [id]);
  }
}
