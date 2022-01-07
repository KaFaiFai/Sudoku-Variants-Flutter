import '../model/sudoku_board.dart';
import '../model/sudoku_puzzle.dart';
import '../model/sudoku_variation.dart';

final sudokuClassicPuzzle = [
  SudokuPuzzle(
    initialBoard: SudokuBoard.fromString(".9.3.8.1."
        "3.......5"
        ".6..5..3."
        "..47.53.."
        "5.2...9.1"
        "..89.27.."
        ".2..6..4."
        "8.......3"
        ".5.1.4.6."),
    solution: SudokuBoard.fromString("495378612"
        "381296475"
        "267451839"
        "914785326"
        "572643981"
        "638912754"
        "523869547"
        "846527193"
        "759134268"),
    variation: SudokuVariation.classic,
    difficulty: 1.6,
  ),
  SudokuPuzzle(
    initialBoard: SudokuBoard.fromString("..1..2.7."
        "3.9..1..."
        ".....9.25"
        "237......"
        "....8...."
        "......642"
        "69.1....."
        "...4..3.6"
        ".8.3..5.."),
    solution: SudokuBoard.fromString("561842973"
        "329571468"
        "874639125"
        "237964851"
        "146285739"
        "958713642"
        "693157284"
        "715428396"
        "482396517"),
    variation: SudokuVariation.classic,
    difficulty: 3.8,
  ),
  SudokuPuzzle(
    initialBoard: SudokuBoard.fromString("7.8......"
        "...4.6.8."
        "4.2.1.3.."
        ".5...8.3."
        "..3...6.."
        ".7.3...2."
        "..7.3.5.6"
        ".9.7.2..."
        "......2.1"),
    solution: SudokuBoard.fromString("718523469"
        "539476182"
        "462819357"
        "251698734"
        "983247615"
        "674351928"
        "827134596"
        "195762843"
        "346985271"),
    variation: SudokuVariation.classic,
    difficulty: 2.3,
  ),
];
