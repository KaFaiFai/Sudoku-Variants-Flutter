import 'package:flutter/foundation.dart';

import '../model/sudoku_rule.dart';
import 'classic_rule.dart';

final disjointRule = SudokuRule(
  title: "Disjoint Sudoku",
  description: "Classic sudoku rules apply.\nIn addition, no two cells that "
      "are in the same relative position in the 3×3 boxes can have the same digit",
  hintCells: (int? row, int? col) {
    if (row == null || col == null) return [];

    final classicCells = classicRule.hintCells(row, col);
    final relativeCells = List.generate(
        9, (i) => [(i ~/ 3) * 3 + row % 3, (i % 3) * 3 + col % 3]);
    return classicCells + relativeCells;
  },
  hasWon: (sudokuBoard) {
    if (sudokuBoard == null) return false;
    final board = sudokuBoard.board;
    final hasWonClassic = classicRule.hasWon(sudokuBoard);
    if (!hasWonClassic) return false;

    for (int i = 0; i < 9; i++) {
      for (int j = 0; i < 9; i++) {
        print("checking cell ($i, $j)");

        final currentSymbol = board[i][j];
        final relativeCells =
            List.generate(9, (k) => [(k ~/ 3) * 3 + i % 3, (k % 3) * 3 + j % 3])
              ..remove([i, j]);

        for (var relativeCell in relativeCells) {
          final relativeSymbol = board[relativeCell[0]][relativeCell[1]];
          if (!listEquals([i, j], relativeCell) &&
              currentSymbol == relativeSymbol) {
            print("Win condition failed: relative position at cell ($i, $j)");
            return false;
          }
        }
      }
    }
    return true;
  },
);
