import 'package:sudoku_variants/utility_function.dart';

import '../model/sudoku_board.dart';
import '../model/sudoku_rule.dart';

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
