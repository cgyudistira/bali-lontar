import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/// Helper class for managing SQLite database operations
class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  /// Get the database instance, initializing if necessary
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('bali_lontar.db');
    return _database!;
  }

  /// Initialize the database
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
    );
  }

  /// Create database tables
  Future<void> _createDB(Database db, int version) async {
    const idType = 'TEXT PRIMARY KEY';
    const textType = 'TEXT NOT NULL';
    const intType = 'INTEGER NOT NULL';
    const textTypeNullable = 'TEXT';

    await db.execute('''
      CREATE TABLE results (
        id $idType,
        timestamp $intType,
        type $textType,
        source_text $textType,
        result_text $textType,
        script_type $textTypeNullable,
        image_path $textTypeNullable,
        metadata $textTypeNullable
      )
    ''');

    // Create indexes for better query performance
    await db.execute('''
      CREATE INDEX idx_timestamp ON results(timestamp DESC)
    ''');

    await db.execute('''
      CREATE INDEX idx_type ON results(type)
    ''');

    await db.execute('''
      CREATE INDEX idx_script_type ON results(script_type)
    ''');
  }

  /// Handle database upgrades
  Future<void> _upgradeDB(Database db, int oldVersion, int newVersion) async {
    // Handle future schema migrations here
    // Example:
    // if (oldVersion < 2) {
    //   await db.execute('ALTER TABLE results ADD COLUMN new_field TEXT');
    // }
  }

  /// Close the database
  Future<void> close() async {
    final db = await database;
    await db.close();
    _database = null;
  }

  /// Delete the database (useful for testing)
  Future<void> deleteDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'bali_lontar.db');
    await deleteDatabase(path);
    _database = null;
  }
}
