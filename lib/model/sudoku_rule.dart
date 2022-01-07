import '../model/sudoku_board.dart';
import '../model/sudoku_symbol.dart';
import '../utility_function.dart';

class SudokuRule {
  static const numberOfRows = 9;
  static const numberOfPartialRows = 3;
  static const numberOfColumns = 9;
  static const numberOfPartialColumns = 3;

  final String title;
  final String description;
  final List<List<int>> Function(int? row, int? col) hintCells;
  final bool Function(SudokuBoard?) hasWon;

  const SudokuRule({
    required this.title,
    required this.description,
    required this.hintCells,
    required this.hasWon,
  });

  static bool isCompleted(SudokuBoard? board) {
    if (board == null) return false;
    for (int i = 0; i < numberOfRows; i++) {
      if (board.board[i].contains(SudokuSymbols.empty)) return false;
    }
    return true;
  }

  static bool includeCell(int? row, int? col) {
    if (row == null || col == null) return false;
    if (row < 0 || row >= numberOfRows || col < 0 || col >= numberOfColumns) {
      return false;
    }
    return true;
  }
}
