import '../model/sudoku_variation.dart';
import '../model/sudoku_board.dart';
import '../model/sudoku_puzzle.dart';
import '../utility_function.dart';

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
    difficulty: 3.0,
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
    difficulty: 4.0,
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
    difficulty: 4.0,
  ),
];

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
    difficulty: 2.0,
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
    difficulty: 5.0,
  ),
  SudokuPuzzle(
    initialBoard: SudokuBoard.fromString("7.......4"
        "..3...1.."
        "........."
        "........."
        ".1....7.8"
        "6.1...7.8"
        ".7.....2."
        "..9...8.."
        ".3.5.8.7."),
    solution: SudokuBoard.fromString("715389264"
        "983462157"
        "264157389"
        "347815692"
        "892746513"
        "651293748"
        "578931426"
        "129674835"
        "436528971"),
    variation: SudokuVariation.antiKnight,
    difficulty: 4.0,
  ),
];

String Function(String) boardRandomizer(
    {bool randSymbols = true, bool randRows = true, bool randCols = true}) {
  var symbols = ['1', '2', '3', '4', '5', '6', '7', '8', '9'];
  var rows = [0, 1, 2, 3, 4, 5, 6, 7, 8];
  var cols = [0, 1, 2, 3, 4, 5, 6, 7, 8];
  if (randSymbols) symbols.shuffle();
  print(symbols);
  if (randRows) rows.shuffle();
  print(rows);
  if (randCols) cols.shuffle();
  print(cols);

  return (board) {
    var board2D = board
        .splitByLength(9)
        .map((sub) => sub.splitByLength(1).toList())
        .toList();
    var board2DRandomized = List.generate(
        board2D.length,
        (i) => List.generate(
            board2D[i].length,
            (j) => symbols.contains(board2D[rows[i]][cols[j]])
                ? symbols[int.parse(board2D[rows[i]][cols[j]]) - 1]
                : board2D[rows[i]][cols[j]]).toList()).toList();
    return board2DRandomized.map((row) {
      var rowText = row.map((e) => e.toString()).toList().join();
      print('"' + rowText + '"');
      return rowText;
    }).join();
  };
}

void main(List<String> args) {
  var rand = boardRandomizer(randRows: false, randCols: false);
  rand("3.......6"
      "..1...4.."
      "........."
      "........."
      ".4....3.9"
      "8.4...3.9"
      ".3.....5."
      "..2...9.."
      ".1.7.9.3.");
  print('\n');
  rand("347192586"
      "291685473"
      "586473192"
      "163947825"
      "925368741"
      "874521369"
      "739214658"
      "452836917"
      "618759234");
}
