import 'package:flutter/material.dart';
import '../constants.dart';
import '../model/sudoku_board.dart';
import '../model/sudoku_symbol.dart';
import '../widget/primitive/cell_button.dart';

class SudokuBoardSubgrid extends StatelessWidget {
  final List<SudokuSymbol>? subboard;
  final List<Set<SudokuSymbol>>? notesSubboard;
  final double length;
  final void Function(int i) onPress;
  final Color? Function(int i) buildDisplayColor;
  final Color? Function(int i) buildBackgroundColor;

  const SudokuBoardSubgrid({
    required this.length,
    this.subboard,
    this.notesSubboard,
    required this.onPress,
    required this.buildDisplayColor,
    required this.buildBackgroundColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        duration: TRANSITION_DURATION,
        curve: Curves.ease,
        width: length * 3.3,
        height: length * 3.3,
        alignment: Alignment.center,
        child: Column(
          children: List.generate(
            5,
            (i) => Row(
              children: List.generate(5, (j) => itemBuilder(i, j)),
              mainAxisAlignment: MainAxisAlignment.spaceAround,
            ),
          ),
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        ),
      ),
    );
  }

  List<List<String>>? _genNotes2D(Set<SudokuSymbol>? notes) {
    if (notes != null) {
      return List.generate(
        3,
        (i) => List.generate(
          3,
          (j) => notes.contains(SudokuSymbols.symbols[i * 3 + j + 1])
              ? SudokuSymbols.symbols[i * 3 + j + 1].text
              : "",
        ),
      );
    }
  }

  Widget itemBuilder(int row, int col) {
    const int count = SudokuBoard.numberOfPartialColumns;
    if ((row == 1 || row == 3) && (col == 1 || col == 3)) {
      return const SizedBox(height: 2, width: 2);
    } else if (row == 1 || row == 3) {
      return Container(
        height: 2,
        width: length - 2,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.elliptical(10, 1)),
          color: PRIMARY_COLOR[500]!,
        ),
      );
    } else if (col == 1 || col == 3) {
      return Container(
        width: 2,
        height: length - 2,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.elliptical(1, 10)),
          color: PRIMARY_COLOR[500]!,
        ),
      );
    }
    int num = (row / 2).floor() * count + (col / 2).floor();
    return CellButton(
      width: length,
      height: length,
      text: subboard?[num] == SudokuSymbols.empty ? null : subboard?[num].text,
      notes: _genNotes2D(notesSubboard?[num]),
      onPress: () => onPress(num),
      displayColor: buildDisplayColor(num),
      backgroundColor: buildBackgroundColor(num),
    );
  }
}
