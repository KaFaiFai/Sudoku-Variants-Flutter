import '../database/sudoku_puzzles_database.dart';
import '../model/sudoku_puzzle.dart';
import '../model/sudoku_variation.dart';

class SudokuPuzzleDao {
  final dbInstance = SudokuPuzzlesDatabase.instance;

  // Create SudokuPuzzle
  Future<SudokuPuzzle> create(SudokuPuzzle puzzle) async {
    final db = await dbInstance.database;

    late final int? id;
    final _allPuzzles = await getAllPuzzles();
    final _duplicatePuzzles = _allPuzzles
        .where((p) =>
            p.toJson()[SudokuPuzzleField.initialBoard] ==
            puzzle.toJson()[SudokuPuzzleField.initialBoard])
        .toList();
    if (_duplicatePuzzles.isEmpty) {
      id = await db.insert(tableSudokuPuzzles, puzzle.toJson());
    } else {
      id = await _updateByInitialBoard(
          puzzle.copyWith(id: _duplicatePuzzles[0].id));
    }
    return puzzle.copyWith(id: id);
  }

  Future<SudokuPuzzle?> getPuzzle(int id) async {
    final db = await dbInstance.database;

    final queryResults = await db.query(
      tableSudokuPuzzles,
      columns: SudokuPuzzleField.all,
      where: '${SudokuPuzzleField.id} = ?',
      whereArgs: [id],
    );

    if (queryResults.isNotEmpty) {
      return SudokuPuzzle.fromJson(queryResults.first);
    } else {
      return null;
    }
  }

  Future<List<SudokuPuzzle>> getAllPuzzles({SudokuVariation? variation}) async {
    print("read start...");
    final db = await dbInstance.database;
    final orderBy = '${SudokuPuzzleField.id} ASC';

    final List<Map<String, Object?>> results;

    if (variation != null) {
      results = await db.query(
        tableSudokuPuzzles,
        orderBy: orderBy,
        where: "${SudokuPuzzleField.variation} LIKE ?",
        whereArgs: ["%${variation.text}%"],
      );
    } else {
      results = await db.query(
        tableSudokuPuzzles,
        orderBy: orderBy,
      );
    }

    print("read end...");
    return results.map((json) => SudokuPuzzle.fromJson(json)).toList();
  }

  Future<int> update(SudokuPuzzle puzzle) async {
    final db = await dbInstance.database;

    return db.update(
      tableSudokuPuzzles,
      puzzle.toJson(),
      where: '${SudokuPuzzleField.id} = ?',
      whereArgs: [puzzle.id],
    );
  }

  Future<int> _updateByInitialBoard(SudokuPuzzle puzzle) async {
    final db = await dbInstance.database;

    return db.update(
      tableSudokuPuzzles,
      puzzle.toJson(),
      where: '${SudokuPuzzleField.initialBoard} = ?',
      whereArgs: [puzzle.toJson()[SudokuPuzzleField.initialBoard]],
    );
  }

  Future<int> delete(int id) async {
    final db = await dbInstance.database;

    return await db.delete(
      tableSudokuPuzzles,
      where: '${SudokuPuzzleField.id} = ?',
      whereArgs: [id],
    );
  }
}
