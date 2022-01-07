import 'package:flutter/foundation.dart';

import '../model/sudoku_rule.dart';
import 'classic_rule.dart';

final positiveDiagonalCells = List.generate(9, (i) => [(9 - i - 1), i]);
final negativeDiagonalCells = List.generate(9, (i) => [i, i]);

final diagonalRule = SudokuRule(
  title: "Diagonal Sudoku",
  description: "Classic sudoku rules apply.\nIn addition, no two cells that "
      "are in the same diagonal can have the same digit",
  hintCells: (int? row, int? col) {
    if (row == null || col == null) return [];

    final classicCells = classicRule.hintCells(row, col);
    List<List<int>> diagonalCells = [];
    if (row + col == 8) {
      diagonalCells += positiveDiagonalCells;
    }
    if (row == col) {
      diagonalCells += negativeDiagonalCells;
    }
    return classicCells + diagonalCells;
  },
  hasWon: (sudokuBoard) {
    if (sudokuBoard == null) return false;
    final board = sudokuBoard.board;
    final hasWonClassic = classicRule.hasWon(sudokuBoard);
    if (!hasWonClassic) return false;

    for (var cell in negativeDiagonalCells) {
      int i = cell[0], j = cell[1];
      print("checking cell ($i, $j)");

      final currentSymbol = board[i][j];
      for (var cell in negativeDiagonalCells) {
        final diagonalSymbol = board[cell[0]][cell[1]];
        if (!listEquals([i, j], cell) && currentSymbol == diagonalSymbol) {
          print("Win condition failed: negative diagonal at cell ($i, $j)");
          return false;
        }
      }
    }

    for (var cell in positiveDiagonalCells) {
      int i = cell[0], j = cell[1];
      print("checking cell ($i, $j)");

      final currentSymbol = board[i][j];
      for (var cell in positiveDiagonalCells) {
        final diagonalSymbol = board[cell[0]][cell[1]];
        if (!listEquals([i, j], cell) && currentSymbol == diagonalSymbol) {
          print("Win condition failed: positive diagonal at cell ($i, $j)");
          return false;
        }
      }
    }

    return true;
  },
);
