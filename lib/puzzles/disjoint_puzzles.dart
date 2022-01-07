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
  SudokuPuzzle(
    initialBoard: SudokuBoard.fromString("8.4...9.."
        ".6.1....."
        "7...8.1.3"
        ".7...5..."
        "..6...7.."
        "...6...3."
        "6.1.4...9"
        ".....9.1."
        "..9...8.4"),
    solution: SudokuBoard.fromString("814523967"
        "963174285"
        "725986143"
        "178235496"
        "536498721"
        "492617538"
        "681742359"
        "347859612"
        "259361874"),
    variation: SudokuVariation.disjoint,
    difficulty: 3.7,
  ),
];
