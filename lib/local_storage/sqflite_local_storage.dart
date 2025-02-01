import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const databaseName = "ProductDatabase.db";
  static const databaseVersion = 1;
  static const table = 'products';
  static const columnId = '_id';
  static const columnImage = 'image';
  static const columnName = 'name';
  static const columnTotalCost = 'totalCost';
  static const columnCutoffCost = 'cutoffCost';
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), databaseName);
    return await openDatabase(
      path,
      version: databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnImage TEXT,
        $columnName TEXT,
        $columnTotalCost TEXT,
        $columnCutoffCost TEXT
      )
    ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(
      table,
      row,
      conflictAlgorithm:
          ConflictAlgorithm.replace, // Ensures duplicate names are replaced
    );
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update(
      table,
      row,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(
      table,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<List<Map<String, dynamic>>> queryRowsByName({
    required String image,
    required String name,
    required String totalCost,
    required String cutoffCost,
  }) async {
    Database db = await instance.database;
    return await db.query(
      table,
      where:
          '$columnImage = ? AND $columnName = ? AND $columnTotalCost = ? AND $columnCutoffCost = ?',
      whereArgs: [
        image,
        name,
        totalCost,
        cutoffCost,
      ],
    );
  }
}
