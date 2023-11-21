import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper_time {
  static const String databaseName = 'newdata.db';
  static const String switchTable = 'switch_table';
  static const String textTable = 'text_table';
  static final DatabaseHelper_time instance = DatabaseHelper_time._privateConstructor();
  late Database _database;

  DatabaseHelper_time._privateConstructor();

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

        await db.execute('''
        CREATE TABLE $textTable (
          id INTEGER PRIMARY KEY,
          text_value TEXT
        )
      ''');

        // Thêm dữ liệu mẫu khi cơ sở dữ liệu rỗng
        var switchTableCount = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $switchTable'));
        var textTableCount = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $textTable'));

        if (switchTableCount == 0 && textTableCount == 0) {
          // Sử dụng batch để chèn nhiều dòng dữ liệu cùng một lúc
          var batch = db.batch();
          batch.insert(
            switchTable,
            {'switch_key': '24 hour format', 'switch_value': 0},
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
          batch.insert(
            switchTable,
            {'switch_key': 'Seconds', 'switch_value': 0},
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
          batch.insert(
            switchTable,
            {'switch_key': 'Music', 'switch_value': 0},
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
          batch.insert(
            switchTable,
            {'switch_key': 'Auto time', 'switch_value': 0},
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
          batch.insert(
            switchTable,
            {'switch_key': 'Auto time-zone', 'switch_value': 0},
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
          batch.insert(
            switchTable,
            {'switch_key': 'Todo list', 'switch_value': 0},
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
          batch.insert(
            switchTable,
            {'switch_key': 'Mascot', 'switch_value': 0},
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
          batch.insert(
            textTable,
            {'id': 1, 'text_value': 'Number clock'},
            conflictAlgorithm: ConflictAlgorithm.replace,
          );

          // Thực hiện batch
          await batch.commit();
        }
      },
    );
  }


  // Future<void> updateSwitch(String key, bool value) async {
  //   final db = await database;
  //   await db.insert(
  //     switchTable,
  //     {'switch_key': key, 'switch_value': value ? 1 : 0},
  //     conflictAlgorithm: ConflictAlgorithm.replace,
  //   );
  // }
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

  // Future<int> updateTask(String key, bool value) async {
  //   final db = await database;
  //   return await db.update('taskss', task.toMap(),
  //       where: 'id = ?', whereArgs: [task.id]);
  // }

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

  Future<void> updateText(String value) async {
    final db = await database;
    await db.rawInsert(
      'INSERT OR REPLACE INTO $textTable (id, text_value) VALUES (?, ?)',
      [1, value],
    );
  }

  Future<String> getTextValue() async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query(
      textTable,
      where: 'id = ?',
      whereArgs: [1],
      limit: 1,
    );
    return result.isNotEmpty ? result.first['text_value'] : '';
  }
}
