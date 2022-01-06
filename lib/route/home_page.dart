import 'package:flutter/material.dart';
import '../constants.dart';
import '../puzzles/all_puzzles.dart';
import '../repository/sudoku_puzzle_repository.dart';
import '../routes.dart';
import '../widget/primitive/simple_button.dart';

class HomePage extends StatelessWidget {
  final sudokuPuzzleRepo = SudokuPuzzleRepository();
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sudoku Variants'),
        backgroundColor: PRIMARY_COLOR[900],
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            SimpleButton(
              child: Text(
                "Start",
                style: TextStyle(color: TERTIARY_COLOR[50]!),
              ),
              border: Border.all(width: 1, color: TERTIARY_COLOR[50]!),
              backgroundColor: PRIMARY_COLOR[900],
              highlightColor: CONTRAST_COLOR,
              onTap: () async {
                for (var puzzle
                    in sudokuClassicPuzzle + sudokuAntiKnightPuzzle) {
                  await sudokuPuzzleRepo.insert(puzzle);
                }
                Navigator.of(context)
                    .pushNamed(RouteGenerator.variationSelectPage);
              },
            ),
            SimpleButton(
              child: Text(
                "Test",
                style: TextStyle(color: TERTIARY_COLOR[50]!),
              ),
              border: Border.all(width: 1, color: TERTIARY_COLOR[50]!),
              backgroundColor: PRIMARY_COLOR[900],
              highlightColor: CONTRAST_COLOR,
              onTap: () => Navigator.of(context)
                  .pushNamed(RouteGenerator.testPage),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        ),
      ),
    );
  }
}
