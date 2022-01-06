import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../model/sudoku_puzzle.dart';
import '../model/sudoku_variation.dart';
import '../repository/sudoku_puzzle_repository.dart';
import '../routes.dart';
import '../state/ui_state.dart';
import '../widget/sudoku_puzzles_tabs.dart';

class LevelSelectPage extends StatefulWidget {
  final SudokuVariation? variation;
  const LevelSelectPage({this.variation, Key? key}) : super(key: key);

  @override
  State<LevelSelectPage> createState() => _LevelSelectPageState();
}

class _LevelSelectPageState extends State<LevelSelectPage>
    with SingleTickerProviderStateMixin {
  final sudokuPuzzleRepo = SudokuPuzzleRepository();
  bool isLoading = true;
  late List<SudokuPuzzle> _puzzles;

  @override
  void initState() {
    super.initState();
    refreshSudokuPuzzles();
  }

  Future refreshSudokuPuzzles() async {
    isLoading = true;
    _puzzles = await sudokuPuzzleRepo.getAll(variation: widget.variation);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose a level'),
        backgroundColor: PRIMARY_COLOR[900],
        elevation: 0,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Consumer<UIState>(
              builder: (_, uiState, __) => SudokuPuzzlesTabs(
                puzzles: _puzzles,
                gridMargin: uiState.currentGridMargin,
                infoOpacity: uiState.currentInfoOpacity,
                subboardLength:
                    (MediaQuery.of(context).size.width - LARGE_MARGIN * 2 - 10) /
                        3,
                onTap: (_) => uiState.toGamePage(),
                onAnimationEnd: (puzzle) {
                  if (uiState.currentPage == RouteGenerator.gamePage) {
                    Navigator.of(context)
                        .pushNamed(RouteGenerator.gamePage, arguments: puzzle)
                        .then((_) => refreshSudokuPuzzles());
                  }
                  uiState.completeTransition();
                },
              ),
            ),
    );
  }
}
