import '../model/sudoku_variation.dart';
import '../model/sudoku_board.dart';
import '../model/sudoku_puzzle.dart';
import '../utility_function.dart';

final sudokuClassicPuzzle = [
  SudokuPuzzle(
    initialBoard: SudokuBoard.fromString("1..5.37..6.3..8.9......98...1...."
        "...8761..........6...........7.8.9.76.47...6.312"),
    solution: SudokuBoard.fromString("19854372664327859152761984391473526887"
        "6192435235486179462351987381927654759864312"),
    variation: SudokuVariation.classic,
    difficulty: 2.2,
  ),
  SudokuPuzzle(
    initialBoard: SudokuBoard.fromString("38.1.........5.6.....9....3.4...."
        ".....5.18.......9.561.6..2478.8.......6..4.8..2."),
    solution: SudokuBoard.fromString("3861729544198536725279468137413"
        "65298695218437238497561163524789852739146974681325"),
    variation: SudokuVariation.classic,
    difficulty: 3.7,
  ),
  SudokuPuzzle(
    initialBoard: SudokuBoard.fromString("8...7.........65.8..13.......46.1"
        "..59...5...7...2..3...75.4.8...1.....53...12...."),
    solution: SudokuBoard.fromString("8425796313974165285613827497846312959238"
        "54167156297384675943812219768453438125976"),
    variation: SudokuVariation.classic,
    difficulty: 3.1,
  ),
  SudokuPuzzle(
    initialBoard: SudokuBoard.fromString(".3...2..1.......6.624..3...3..7..8.."
        "2.....3....12.4..7...51....4.......5..9....7."),
    solution: SudokuBoard.fromString("93586274117849526362417359834675182925798"
        "6314891234657782519436413627985569348172"),
    variation: SudokuVariation.classic,
    difficulty: 4.8,
  ),
  SudokuPuzzle(
    initialBoard: SudokuBoard.fromString("2............81..5..623..914...1..7"
        "..5.978.2..2......89.........1.65.7..........."),
    solution: SudokuBoard.fromString("28159643739478126557623489146831257915"
        "3978624729465318947823156812659743635147982"),
    variation: SudokuVariation.classic,
    difficulty: 2.8,
  ),
  SudokuPuzzle(
    initialBoard: SudokuBoard.fromString("61...28...8..4..5...5..........8...1."
        ".....4..192.......6....2.5...7...3.4...39..7"),
    solution: SudokuBoard.fromString("6173528493896417522459783165342879618761"
        "95423192463578763814295958726134421539687"),
    variation: SudokuVariation.classic,
    difficulty: 3.7,
  ),
  SudokuPuzzle(
    initialBoard: SudokuBoard.fromString("6173528493896.17522459783165342879618"
        "76195423192463578763814295958726134421539687"),
    solution: SudokuBoard.fromString("6173528493896417522459783165342879618761"
        "95423192463578763814295958726134421539687"),
    variation: SudokuVariation.classic,
    difficulty: 0.1,
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
];

String Function(String) boardRandomizer(
    {bool randSymbols = true, bool randRows = true, bool randCols = true}) {
  var symbols = ['1', '2', '3', '4', '5', '6', '7', '8', '9'];
  var rows = [0, 1, 2, 3, 4, 5, 6, 7, 8];
  var cols = [0, 1, 2, 3, 4, 5, 6, 7, 8];
  if (randSymbols) symbols.shuffle();
  print(symbols);
  if (randRows) rows.shuffle();
  if (randCols) cols.shuffle();

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
  rand("2....8..."
      ".5....2.."
      "..7....9."
      "...3....9"
      "....4...."
      "3....1..."
      ".1....5.."
      "..4....1."
      "...5....2");
  print('\n');
  rand("293158467"
      "651497238"
      "487632195"
      "148325679"
      "765849321"
      "329761854"
      "812976543"
      "574283916"
      "936514782");
}
