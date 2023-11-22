import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper_alarm_switch {
  static const String databaseName = 'newdata_alarm.db';
  static const String switchTable = 'switch_alarm_one';
  static final DatabaseHelper_alarm_switch instance = DatabaseHelper_alarm_switch
      ._privateConstructor();
  late Database _database;

  DatabaseHelper_alarm_switch._privateConstructor();

  Future<Database> get database async {
    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    final path = await getDatabasesPath();
    final databasePath = join(path, databaseName);

    return await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE $switchTable (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          switch_key TEXT,
          switch_value INTEGER
        )
      ''');


        // Thêm dữ liệu mẫu khi cơ sở dữ liệu rỗng
        var switchTableCount = Sqflite.firstIntValue(
            await db.rawQuery('SELECT COUNT(*) FROM $switchTable'));

        if (switchTableCount == 0) {
          // Sử dụng batch để chèn nhiều dòng dữ liệu cùng một lúc
          var batch = db.batch();
          batch.insert(
            switchTable,
            {'switch_key': 'Sound', 'switch_value': 0},
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
          batch.insert(
            switchTable,
            {'switch_key': 'Quiver', 'switch_value': 0},
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
          batch.insert(
            switchTable,
            {'switch_key': 'Snooze', 'switch_value': 0},
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
          batch.insert(
            switchTable,
            {'switch_key': 'Repeat', 'switch_value': 0},
            conflictAlgorithm: ConflictAlgorithm.replace,
          );

          // Thực hiện batch
          await batch.commit();
        }
      },
    );
  }

  Future<void> updateSwitch(String key, bool value) async {
    final db = await database;
    int switchValue = value ? 1 : 0;

    await db.update(
      switchTable,
      {'switch_value': switchValue},
      where: 'switch_key = ?',
      whereArgs: [key],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<bool> getSwitchValue(String key) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query(
      switchTable,
      where: 'switch_key = ?',
      whereArgs: [key],
      limit: 1,
    );
    return result.isNotEmpty ? result.first['switch_value'] == 1 : false;
  }
}
