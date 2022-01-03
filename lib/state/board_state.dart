import 'package:flutter/material.dart';
import '../model/sudoku_board.dart';
import '../model/sudoku_puzzle.dart';
import '../model/sudoku_rule.dart';
import '../model/sudoku_symbol.dart';
import '../model/sudoku_variation.dart';

enum Selection { cell, symbol }

class BoardState extends ChangeNotifier {
  SudokuBoard? _initialBoard = SudokuBoard.empty();
  SudokuBoard? _currentBoard = SudokuBoard.empty();
  SudokuVariation? _variation;
  Selection? _selection;
  int? _row;
  int? _col;
  SudokuSymbol? _symbol;
  bool _inputtingNotes = false;
  bool _isCompleted = false;
  bool _hasWon = false;

  SudokuBoard? get initialBoard => _initialBoard;
  SudokuBoard? get currentBoard => _currentBoard;
  SudokuVariation? get currentVariation => _variation;
  Selection? get currentSelection => _selection;
  int? get currentRow => _row;
  int? get currentColumn => _col;
  SudokuSymbol? get currentSymbol => _symbol;
  bool get inputtingNotes => _inputtingNotes;
  bool get isCompleted => _isCompleted;
  bool get hasWon => _hasWon;

  void reset() {
    _initialBoard = null;
    _currentBoard = null;
    _variation = null;
    _selection = null;
    _row = null;
    _col = null;
    _symbol = null;
    _inputtingNotes = false;
    _isCompleted = false;
    _hasWon = false;
    notifyListeners();
  }

  void setCurrentPuzzle(SudokuPuzzle? newPuzzle) {
    _initialBoard = newPuzzle?.initialBoard.copy();
    _currentBoard = newPuzzle?.savedBoard?.copy();
    _variation = newPuzzle?.variation;
    notifyListeners();
  }

  void selectCell(int? row, int? col) {
    if (_selection != Selection.symbol) {
      if (row == _row && col == _col) {
        _row = null;
        _col = null;
        _selection = null;
      } else {
        _row = row;
        _col = col;
        _selection = Selection.cell;
      }
    } else {
      _updateCell(row, col, _symbol);
    }
    print(
        "_selection: $_selection, _row: $_row, _col: $_col, _symbol: $_symbol");
    notifyListeners();
  }

  void selectSymbol(SudokuSymbol symbol) {
    if (_selection != Selection.cell) {
      if (symbol == _symbol) {
        _symbol = null;
        _selection = null;
      } else {
        _symbol = symbol;
        _selection = Selection.symbol;
      }
    } else {
      _updateCell(_row, _col, symbol);
    }
    print(
        "_selection: $_selection, _row: $_row, _col: $_col, _symbol: $_symbol");
    notifyListeners();
  }

  void changeInputMethod() {
    _inputtingNotes = !_inputtingNotes;
    notifyListeners();
  }

  void _updateCell(int? row, int? col, SudokuSymbol? symbol) {
    if (row != null &&
        col != null &&
        symbol != null &&
        _initialBoard?.board[row][col] == SudokuSymbols.empty) {
      if (!_inputtingNotes) {
        _currentBoard?.updateCell(row, col, symbol);
      } else {
        _currentBoard?.updateNotes(row, col, symbol);
      }
    }
    _isCompleted = SudokuRule.isCompleted(_currentBoard);
    _hasWon =
        _variation != null ? _variation!.rule.hasWon(_currentBoard) : false;
    notifyListeners();
  }
}
