import '../model/sudoku_rule.dart';
import 'classic_rule.dart';

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
        print("checking cell ($i, $j)");

        final currentCell = board[i][j];
        for (int k = 0; k < _knightMoves.length; k++) {
          if (SudokuRule.includeCell(
              i + _knightMoves[k][0], j + _knightMoves[k][1])) {
            print("validating cell ($i, $j)");
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
