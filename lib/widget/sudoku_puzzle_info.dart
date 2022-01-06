import 'package:flutter/material.dart';
import 'package:sudoku_variants/widget/primitive/fractional_widget.dart';
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
        body: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Sudoku ${puzzle.id}",
                      style: TextStyle(
                        color: TERTIARY_COLOR[100],
                        height: 1.5,
                        fontSize: 30,
                      ),
                    ),
                    if (puzzle.difficulty != null)
                      Row(
                        children: List<Widget>.generate(
                                puzzle.difficulty?.floor() ?? 0,
                                (i) => Icon(
                                      Icons.star,
                                      size: 40,
                                      color: CONTRAST_COLOR[300]!,
                                    )) +
                            [
                              FractionalWidget(
                                color: CONTRAST_COLOR[300]!,
                                proportion: puzzle.difficulty! -
                                    puzzle.difficulty!.floor(),
                                child: const Icon(Icons.star, size: 40),
                              ),
                            ],
                      ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: puzzle.hasWon
                  ? const Icon(Icons.done, color: CONTRAST_COLOR, size: 40)
                  : null,
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
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
