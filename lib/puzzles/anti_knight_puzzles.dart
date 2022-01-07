import '../model/sudoku_board.dart';
import '../model/sudoku_puzzle.dart';
import '../model/sudoku_variation.dart';

final sudokuAntiKnightPuzzle = [
  SudokuPuzzle(
    initialBoard: SudokuBoard.fromString("3.......8"
        ".8..3..5."
        "..5...2.."
        "...965..."
        ".1.324.7."
        "...871..."
        "..8...9.."
        ".9..4..1."
        "5.......7"),
    solution: SudokuBoard.fromString("324759168"
        "186432759"
        "975186234"
        "247965381"
        "819324576"
        "653871492"
        "438617925"
        "792548613"
        "561293847"),
    variation: SudokuVariation.antiKnight,
    difficulty: 1.2,
  ),
  SudokuPuzzle(
    initialBoard: SudokuBoard.fromString("7....1..."
        ".9....7.."
        "..8....5."
        "...3....5"
        "....6...."
        "3....4..."
        ".4....9.."
        "..6....4."
        "...9....7"),
    solution: SudokuBoard.fromString("753491628"
        "294658731"
        "618237459"
        "461379285"
        "829165374"
        "375824196"
        "147582963"
        "986713542"
        "532946817"),
    variation: SudokuVariation.antiKnight,
    difficulty: 4.8,
  ),
  SudokuPuzzle(
    initialBoard: SudokuBoard.fromString("1.......2"
        "..5...6.."
        "8.......9"
        "........."
        "........."
        "7.6...1.4"
        ".1.....8."
        "..9...4.."
        ".5.3.4.1."),
    solution: SudokuBoard.fromString("163549872"
        "945278631"
        "872631549"
        "521463798"
        "498127365"
        "736895124"
        "314956287"
        "689712453"
        "257384916"),
    variation: SudokuVariation.antiKnight,
    difficulty: 4.3,
  ),
];
