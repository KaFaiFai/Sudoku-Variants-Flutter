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
        title: const Text(''),
        backgroundColor: PRIMARY_COLOR[900],
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 50),
            Expanded(
              flex: 4,
              child: Image.asset(
                "assets/images/sudoku_icon.png",
                fit: BoxFit.scaleDown,
              ),
            ),
            Expanded(
              flex: 6,
              child: Center(
                child: SimpleButton(
                  child: Text(
                    "Start",
                    style: TextStyle(color: TERTIARY_COLOR[50]!),
                  ),
                  border: Border.all(width: 1, color: TERTIARY_COLOR[50]!),
                  backgroundColor: PRIMARY_COLOR[900],
                  highlightColor: CONTRAST_COLOR,
                  onTap: () async {
                    for (var variants in allSudokuPuzzles) {
                      for (var puzzle in variants) {
                        await sudokuPuzzleRepo.insert(puzzle);
                      }
                    }
                    Navigator.of(context)
                        .pushNamed(RouteGenerator.variationSelectPage);
                  },
                ),
              ),
            ),
            const SizedBox(height: 100),
            /*SimpleButton(
              child: Text(
                "icon",
                style: TextStyle(color: TERTIARY_COLOR[50]!),
              ),
              border: Border.all(width: 1, color: TERTIARY_COLOR[50]!),
              backgroundColor: PRIMARY_COLOR[900],
              highlightColor: CONTRAST_COLOR,
              onTap: () => Navigator.of(context)
                  .pushNamed(RouteGenerator.iconPage),
            ),*/
          ],
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        ),
      ),
    );
  }
}
