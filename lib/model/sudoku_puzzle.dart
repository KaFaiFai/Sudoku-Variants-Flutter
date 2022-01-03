import '../model/sudoku_board.dart';
import '../model/sudoku_variation.dart';

const undefined = Object();

class SudokuPuzzleField {
  static const List<String> all = [
    id,
    variation,
    initialBoard,
    savedBoard,
    savedNotes,
    solution,
    difficulty,
    hasWon,
  ];

  static const String id = '_id';
  static const String variation = 'variation';
  static const String initialBoard = 'initialBoard';
  static const String savedBoard = 'savedBoard';
  static const String savedNotes = 'savedNotes';
  static const String solution = 'solution';
  static const String difficulty = 'difficulty';
  static const String hasWon = 'hasWon';

  SudokuPuzzleField._();
}

class SudokuPuzzle {
  final int? id;
  late final SudokuVariation variation;
  final SudokuBoard initialBoard;
  final SudokuBoard? savedBoard;
  final SudokuBoard solution;
  final double? difficulty;
  final bool hasWon;

  SudokuPuzzle({
    this.id,
    SudokuVariation? variation,
    required this.initialBoard,
    SudokuBoard? savedBoard,
    required this.solution,
    this.difficulty,
    this.hasWon = false,
  })  : variation = variation ?? SudokuVariation.classic,
        savedBoard = savedBoard ?? initialBoard;

  SudokuPuzzle copyWith({
    Object? id = undefined,
    SudokuVariation? variation,
    SudokuBoard? initialBoard,
    SudokuBoard? savedBoard,
    SudokuBoard? solution,
    double? difficulty,
    bool? hasWon,
  }) =>
      SudokuPuzzle(
        id: id == undefined ? this.id : id as int?,
        variation: variation ?? this.variation,
        initialBoard: initialBoard ?? this.initialBoard,
        savedBoard: savedBoard ?? this.savedBoard,
        solution: solution ?? this.solution,
        difficulty: difficulty ?? this.difficulty,
        hasWon: hasWon ?? this.hasWon,
      );

  static SudokuPuzzle fromJson(Map<String, Object?> json) => SudokuPuzzle(
        id: json[SudokuPuzzleField.id] as int?,
        variation:
            SudokuVariation.from(json[SudokuPuzzleField.variation] as String),
        initialBoard: SudokuBoard.fromString(
            json[SudokuPuzzleField.initialBoard] as String),
        savedBoard: SudokuBoard.fromString(
            json[SudokuPuzzleField.savedBoard] as String,
            json[SudokuPuzzleField.savedNotes] as String),
        solution:
            SudokuBoard.fromString(json[SudokuPuzzleField.solution] as String),
        difficulty: json[SudokuPuzzleField.difficulty] as double?,
        hasWon: (json[SudokuPuzzleField.hasWon] as int) == 1,
      );

  Map<String, Object?> toJson() => {
        SudokuPuzzleField.id: id,
        SudokuPuzzleField.variation: variation.text,
        SudokuPuzzleField.initialBoard: initialBoard.boardToJson(),
        SudokuPuzzleField.savedBoard: savedBoard?.boardToJson() ?? "",
        SudokuPuzzleField.savedNotes: savedBoard?.notesToJson() ?? "",
        SudokuPuzzleField.solution: solution.boardToJson(),
        SudokuPuzzleField.difficulty: difficulty,
        SudokuPuzzleField.hasWon: hasWon ? 1 : 0,
      };
}
