import 'package:flutter/material.dart';
import '../constants.dart';
import '../model/sudoku_puzzle.dart';

class SudokuPuzzleInfo extends StatelessWidget {
  final SudokuPuzzle puzzle;
  final void Function(SudokuPuzzle) onPress;
  final double opacity;

  const SudokuPuzzleInfo({
    required this.puzzle,
    required this.onPress,
    this.opacity = 1.0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: TRANSITION_DURATION,
      child: Scaffold(
        body: ListTile(
          title: Text(
            "Sudoku ${puzzle.id}",
            style: TextStyle(color: TERTIARY_COLOR[50]),
          ),
          subtitle: Text(
            "${puzzle.difficulty}⭐",
            style: TextStyle(color: TERTIARY_COLOR[50]),
          ),
          trailing: puzzle.hasWon
              ? const Icon(Icons.done, color: CONTRAST_COLOR, size: 40)
              : null,
        ),
        floatingActionButton: TextButton(
          child: Icon(Icons.play_arrow, color: TERTIARY_COLOR[50], size: 40),
          style: TextButton.styleFrom(
              backgroundColor: CONTRAST_COLOR, shape: const CircleBorder()),
          onPressed: () => onPress(puzzle),
        ),
      ),
    );
  }
}
