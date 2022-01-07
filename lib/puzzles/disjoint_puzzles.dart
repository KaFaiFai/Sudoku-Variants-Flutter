import '../model/sudoku_board.dart';
import '../model/sudoku_puzzle.dart';
import '../model/sudoku_variation.dart';

final sudokuDisjointPuzzle = [
  SudokuPuzzle(
    initialBoard: SudokuBoard.fromString("...654..."
        "..1...6.."
        ".5.....7."
        "3.9...2.5"
        ".2.3.9.8."
        "8.6...3.9"
        ".6.....3."
        "..2...8.."
        "...738..."),
    solution: SudokuBoard.fromString("987654123"
        "241973658"
        "653281974"
        "379846215"
        "524319786"
        "816527349"
        "768492531"
        "432165897"
        "195738462"),
    variation: SudokuVariation.disjoint,
    difficulty: 2.5,
  ),
];
