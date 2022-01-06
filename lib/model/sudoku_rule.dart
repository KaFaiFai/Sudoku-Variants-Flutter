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

final classicRule = SudokuRule(
  title: "Classic Sudoku",
  description: "Each column, row and 3×3 outlined box "
      "contains digits from 1 to 9 without repetition.",
  hintCells: (int? row, int? col) {
    if (row == null || col == null) return [];

    final verticalCells =
        List.generate(SudokuRule.numberOfRows, (i) => [row, i]);
    final horizontalCells =
        List.generate(SudokuRule.numberOfColumns, (i) => [i, col]);
    final subboardCells = List.generate(
        SudokuRule.numberOfPartialRows * SudokuRule.numberOfPartialColumns,
        (i) => [
              (row ~/ 3) * 3 + i ~/ SudokuRule.numberOfPartialRows,
              (col ~/ 3) * 3 + i % SudokuRule.numberOfPartialColumns
            ]);

    return verticalCells + horizontalCells + subboardCells;
  },
  hasWon: (SudokuBoard? sudokuBoard) {
    if (sudokuBoard == null) return false;

    final board = sudokuBoard.board;
    if (!SudokuRule.isCompleted(sudokuBoard)) {
      print("Win condition failed:: not completed");
      return false;
    }

    for (int i = 0; i < SudokuRule.numberOfRows; i++) {
      final currentRow = [...board[i]];
      if (!currentRow.isUnique()) {
        print("Win condition failed: $i-th row");
        return false;
      }
    }
    for (int i = 0; i < SudokuRule.numberOfColumns; i++) {
      final currentColumn =
          List.generate(SudokuRule.numberOfRows, (j) => board[j][i]);
      if (!currentColumn.isUnique()) {
        print("Win condition failed: $i-th column");
        return false;
      }
    }
    for (int i = 0; i < 9; i++) {
      final currentSubboard = sudokuBoard.subboard1D(i)!;
      if (!currentSubboard.isUnique()) {
        print("Win condition failed: $i-th subboard");
        return false;
      }
    }

    return true;
  },
);

const _knightMoves = [
  [1, 2],
  [2, 1],
  [-1, 2],
  [-2, 1],
  [1, -2],
  [2, -1],
  [-1, -2],
  [-2, -1]
];

final antiKnightRule = SudokuRule(
  title: "Anti-knight Sudoku",
  description: "Classic sudoku rules apply.\nIn addition, no two cells that "
      "are a Knight's move apart, as in chess, can have the same digit",
  hintCells: (int? row, int? col) {
    if (row == null || col == null) return [];

    final classicCells = classicRule.hintCells(row, col);
    final knightCells = List.generate(_knightMoves.length,
        (i) => [row + _knightMoves[i][0], col + _knightMoves[i][1]]);
    return classicCells + knightCells;
  },
  hasWon: (sudokuBoard) {
    if (sudokuBoard == null) return false;
    final board = sudokuBoard.board;
    final hasWonClassic = classicRule.hasWon(sudokuBoard);
    if (!hasWonClassic) return false;

    for (int i = 0; i < 9; i++) {
      for (int j = 0; i < 9; i++) {
        print("hello");

        final currentCell = board[i][j];
        for (int k = 0; k < _knightMoves.length; k++) {
          if (SudokuRule.includeCell(
              i + _knightMoves[k][0], j + _knightMoves[k][1])) {
            print("hello");
            final knightCell =
                board[i + _knightMoves[k][0]][j + _knightMoves[k][1]];
            if (currentCell == knightCell) {
              print("Win condition failed: knight move at cell ($i, $j)");
              return false;
            }
          }
        }
      }
    }
    return true;
  },
);
