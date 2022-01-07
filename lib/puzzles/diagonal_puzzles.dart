import '../model/sudoku_board.dart';
import '../model/sudoku_puzzle.dart';
import '../model/sudoku_variation.dart';

final sudokuDiagonalPuzzle = [
  SudokuPuzzle(
    initialBoard: SudokuBoard.fromString(".8.....9."
        "5.3...8.2"
        ".4.1.2.6."
        "..1.3.4.."
        "...4.1..."
        "..4.6.5.."
        ".2.7.3.5."
        "3.7...2.9"
        ".9.....8."),
    solution: SudokuBoard.fromString("987654123"
        "241973658"
        "653281974"
        "379846215"
        "524319786"
        "816527349"
        "768492531"
        "432165897"
        "195738462"),
    variation: SudokuVariation.diagonal,
    difficulty: 2.2,
  ),
];
