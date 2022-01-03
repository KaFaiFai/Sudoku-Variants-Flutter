import '../model/sudoku_rule.dart';
import '../model/sudoku_symbol.dart';
import '../utility_function.dart';

class SudokuBoard {
  static const numberOfRows = SudokuRule.numberOfRows;
  static const numberOfPartialRows = SudokuRule.numberOfPartialRows;
  static const numberOfColumns = SudokuRule.numberOfColumns;
  static const numberOfPartialColumns = SudokuRule.numberOfPartialColumns;
  List<List<SudokuSymbol>> _board = [];
  List<List<Set<SudokuSymbol>>> _notesBoard = [];

  SudokuBoard(List<List<SudokuSymbol>> board,
      [List<List<Set<SudokuSymbol>>>? notes]) {
    this.board = board;
    notesBoard = notes ?? [[]];
  }

  SudokuBoard.fromString(String board, [String? notes]) {
    this.board = board
        .splitByLength(numberOfColumns)
        .map((sub) =>
            sub.splitByLength(1).map((e) => SudokuSymbols.from(e)).toList())
        .toList()
        .toList();

    if (notes != null) {
      notesBoard = notes
          .split(",")
          .splitByLength(numberOfColumns)
          .map((row) => row
              .map((s) =>
                  s.splitByLength(1).map((e) => SudokuSymbols.from(e)).toSet())
              .toList())
          .toList();
    } else {
      notesBoard = List.generate(
        numberOfRows,
        (i) => List.generate(numberOfColumns, (j) => {}),
      );
    }
  }

  SudokuBoard.empty() : this([]);

  List<List<SudokuSymbol>> get board => _board;
  List<List<Set<SudokuSymbol>>> get notesBoard => _notesBoard;

  set board(List<List<SudokuSymbol>> board) {
    final List<List<SudokuSymbol>> newBoard = List.generate(
      numberOfRows,
      (i) => List.generate(
        numberOfColumns,
        (j) {
          if (board.length > i && board[i].length > j) {
            return board[i][j];
          } else {
            return SudokuSymbols.empty;
          }
        },
      ),
    );

    _board = newBoard;
  }

  set notesBoard(List<List<Set<SudokuSymbol>>> notesBoard) {
    final List<List<Set<SudokuSymbol>>> newNotesBoard = List.generate(
      numberOfRows,
      (i) => List.generate(
        numberOfColumns,
        (j) {
          if (notesBoard.length > i && notesBoard[i].length > j) {
            return notesBoard[i][j];
          } else {
            return {};
          }
        },
      ),
    );

    _notesBoard = newNotesBoard;
  }

  void updateCell(int row, int col, SudokuSymbol symbol) {
    if (0 <= row &&
        row < SudokuBoard.numberOfRows &&
        0 <= col &&
        col < SudokuBoard.numberOfColumns) {
      if (symbol == _board[row][col]) {
        _board[row][col] = SudokuSymbols.empty;
      } else {
        _board[row][col] = symbol;
      }
      _notesBoard[row][col].clear();
    } else {
      throw Exception("Out of board range: try to update cell at ($row,$col)");
    }
  }

  void updateNotes(int row, int col, SudokuSymbol symbol) {
    if (0 <= row &&
        row < SudokuBoard.numberOfRows &&
        0 <= col &&
        col < SudokuBoard.numberOfColumns) {
      if (symbol != SudokuSymbols.empty) {
        if (_notesBoard[row][col].contains(symbol)) {
          _notesBoard[row][col].remove(symbol);
        } else {
          _notesBoard[row][col].add(symbol);
        }
      } else {
        _notesBoard[row][col].clear();
      }
      _board[row][col] = SudokuSymbols.empty;
    } else {
      throw Exception("Out of board range: try to update cell at ($row,$col)");
    }
  }

  List<SudokuSymbol>? subboard1D(int i) {
    if (0 <= i && i <= 8) {
      return List.generate(
        numberOfPartialRows * numberOfPartialColumns,
        (j) => board[(i ~/ 3) * 3 + j ~/ numberOfPartialRows]
            [(i % 3) * 3 + j % numberOfPartialColumns],
      );
    }
  }

  List<List<int>> sameSymbol(SudokuSymbol? s) {
    if (s == null) return [];
    List<List<int>> cells = [];
    for (var i = 0; i < numberOfRows; i++) {
      for (var j = 0; j < numberOfColumns; j++) {
        if (board[i][j] == s || notesBoard[i][j].contains(s)) {
          cells.add([i, j]);
        }
      }
    }
    return cells;
  }

  List<Set<SudokuSymbol>>? notesSubboard1D(int i) {
    if (0 <= i && i <= 8) {
      return List.generate(
        numberOfPartialRows * numberOfPartialColumns,
        (j) => notesBoard[(i ~/ 3) * 3 + j ~/ numberOfPartialRows]
            [(i % 3) * 3 + j % numberOfPartialColumns],
      );
    }
  }

  String boardToJson() =>
      _board.map((row) => row.map((s) => s.text).join()).join();
  String notesToJson() => _notesBoard
      .map((row) => row.map((s) => s.map((e) => e.text).join()).join(','))
      .join(',');

  SudokuBoard copy() => SudokuBoard(_board, _notesBoard);
}
