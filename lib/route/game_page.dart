import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../model/sudoku_board.dart';
import '../model/sudoku_puzzle.dart';
import '../model/sudoku_variation.dart';
import '../repository/sudoku_puzzle_repository.dart';
import '../state/board_state.dart';
import '../state/ui_state.dart';
import '../widget/sudoku_board_grid.dart';
import '../widget/sudoku_input_buttons.dart';

class GamePage extends StatefulWidget {
  final SudokuPuzzle puzzle;
  const GamePage({required this.puzzle, Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final _sudokuPuzzleRepo = SudokuPuzzleRepository();

  @override
  void initState() {
    super.initState();
    final _boardListener = Provider.of<BoardState>(context, listen: false);
    _boardListener.reset();
    _boardListener.setCurrentPuzzle(widget.puzzle);
  }

  @override
  Widget build(BuildContext context) {
    final _uiListener = Provider.of<UIState>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => _uiListener.toSelectPage(Navigator.of(context).pop),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(widget.puzzle.variation.rule.title),
                  content: Text(
                    widget.puzzle.variation.rule.description,
                    style: const TextStyle(height: 1.5),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
        backgroundColor: PRIMARY_COLOR[900],
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              flex: 7,
              child: Consumer<BoardState>(
                builder: (_, boardState, __) => SudokuBoardGrid(
                  initialBoard: boardState.initialBoard ?? SudokuBoard.empty(),
                  currentBoard: boardState.currentBoard ?? SudokuBoard.empty(),
                  variation:
                      boardState.currentVariation ?? SudokuVariation.classic,
                  selectedCell: [
                    boardState.currentRow,
                    boardState.currentColumn
                  ],
                  selectedSymbol: boardState.currentSymbol,
                  subboardLength: (MediaQuery.of(context).size.width -
                          SMALL_MARGIN * 2 -
                          10) /
                      3,
                  onEnd: _uiListener.completeTransition,
                  onPress: (r, c) {
                    boardState.selectCell(r, c);
                    final hasWon = boardState.hasWon;
                    if (boardState.isCompleted) {
                      _showCompleteMessage(context, hasWon);
                    }
                    _sudokuPuzzleRepo.update(widget.puzzle.copyWith(
                      savedBoard: boardState.currentBoard,
                      hasWon: hasWon,
                    ));
                    setState(() {});
                  },
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Consumer<BoardState>(
                builder: (_, boardState, __) => SudokuInputButtons(
                  inputtingNotes: boardState.inputtingNotes,
                  selectedSymbol:
                      boardState.currentSelection == Selection.symbol
                          ? boardState.currentSymbol
                          : null,
                  onPressSymbol: (s) {
                    boardState.selectSymbol(s);
                    final hasWon = boardState.hasWon;
                    if (boardState.isCompleted) {
                      _showCompleteMessage(context, hasWon);
                    }
                    _sudokuPuzzleRepo.update(widget.puzzle.copyWith(
                      savedBoard: boardState.currentBoard,
                      hasWon: hasWon,
                    ));
                    setState(() {});
                  },
                  onChangeInputMethod: () {
                    boardState.changeInputMethod();
                    print(
                        "boardState.inputtingNotes: ${boardState.inputtingNotes}");
                    setState(() {});
                  },
                ),
              ),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        ),
      ),
    );
  }
}

void _showCompleteMessage(BuildContext context, bool hasWon) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(hasWon ? 'Completed!' : "Incorrect!"),
      content: Text(
        hasWon ? 'You have completed this Sudoku.' : "Please continue",
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
