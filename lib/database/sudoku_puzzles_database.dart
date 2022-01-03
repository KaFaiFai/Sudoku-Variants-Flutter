import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/sudoku_puzzle.dart';

const databaseSudokuPuzzles = 'test_db.db';
const tableSudokuPuzzles = 'test1';

class SudokuPuzzlesDatabase {
  static final SudokuPuzzlesDatabase instance = SudokuPuzzlesDatabase._init();

  static Database? _database;

  SudokuPuzzlesDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB(databaseSudokuPuzzles);

    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const textType = 'TEXT';
    const intType = "INTEGER";
    const doubleType = 'REAL';
    const notNull = 'NOT NULL';
    const unique = "UNIQUE";

    await db.execute('''
    CREATE TABLE $tableSudokuPuzzles (
      ${SudokuPuzzleField.id} $idType,
      ${SudokuPuzzleField.variation} $textType $notNull,
      ${SudokuPuzzleField.initialBoard} $textType $notNull $unique,
      ${SudokuPuzzleField.savedBoard} $textType $notNull,
      ${SudokuPuzzleField.savedNotes} $textType $notNull,
      ${SudokuPuzzleField.solution} $textType $notNull,
      ${SudokuPuzzleField.difficulty} $doubleType,
      ${SudokuPuzzleField.hasWon} $intType $notNull)
      ''');
  }

  Future close() async {
    final db = await instance.database;

    db.close();
    _database = null;
  }
}
