import 'package:flutter/material.dart';
import '../constants.dart';
import '../model/sudoku_puzzle.dart';
import '../model/sudoku_symbol.dart';
import '../repository/sudoku_puzzle_repository.dart';
import '../routes.dart';
import '../widget/sudoku_board_subgrid.dart';
import '../widget/sudoku_puzzles_tabs.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage>
    with SingleTickerProviderStateMixin {
  double gridMargin = LARGE_MARGIN;
  double infoOpacity = 1.0;
  final sudokuPuzzleRepo = SudokuPuzzleRepository();
  bool isLoading = true;
  late List<SudokuPuzzle> _puzzles;

  Future refreshSudokuPuzzles() async {
    isLoading = true;
    _puzzles = await sudokuPuzzleRepo.getAll();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    refreshSudokuPuzzles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sudoku Test'),
        ),
        body: SudokuBoardSubgrid(
            length: 30,
            subboard: const [
              SudokuSymbols.one,
              SudokuSymbols.two,
              SudokuSymbols.three,
              SudokuSymbols.one,
              SudokuSymbols.two,
              SudokuSymbols.three,
              SudokuSymbols.one,
              SudokuSymbols.two,
              SudokuSymbols.three,
            ],
            onPress: (_) {},
            buildDisplayColor: (_) => Colors.blue,
            buildBackgroundColor: (_) => Colors.blue[100]));
  }
}
