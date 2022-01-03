import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sudoku_variants/model/sudoku_symbol.dart';
import '../constants.dart';
import '../model/sudoku_board.dart';
import '../model/sudoku_variation.dart';
import '../widget/sudoku_board_subgrid.dart';

class SudokuBoardGrid extends StatefulWidget {
  final SudokuBoard initialBoard;
  final SudokuBoard currentBoard;
  final SudokuVariation variation;
  final List<int?>? selectedCell;
  final SudokuSymbol? selectedSymbol;
  final double margin;
  final double subboardLength;
  final void Function()? onEnd;
  final void Function(int row, int col) onPress;
  late final List<List<int>> _highlightedCells;

  SudokuBoardGrid({
    required this.initialBoard,
    required this.currentBoard,
    required this.variation,
    this.selectedCell,
    this.selectedSymbol,
    required this.onPress,
    this.margin = SMALL_MARGIN,
    required this.subboardLength,
    this.onEnd,
    Key? key,
  }) : super(key: key) {
    _highlightedCells =
        variation.rule.hintCells(selectedCell?[0], selectedCell?[1]) +
            currentBoard.sameSymbol(selectedSymbol);
  }

  @override
  State<SudokuBoardGrid> createState() => _SudokuBoardGridState();
}

class _SudokuBoardGridState extends State<SudokuBoardGrid> {
  Color? _cellTextColor(int row, int col) {
    if (widget.currentBoard.board[row][col] ==
        widget.initialBoard.board[row][col]) {
      return TERTIARY_COLOR[500];
    } else {
      return TERTIARY_COLOR[50];
    }
  }

  Color? _cellBackgroundColor(int row, int col) {
    if (listEquals(widget.selectedCell, [row, col])) {
      return PRIMARY_COLOR[500];
    } else if (widget._highlightedCells
        .any((cell) => listEquals(cell, [row, col]))) {
      return PRIMARY_COLOR[800];
    }
  }

  @override
  Widget build(BuildContext context) {
    var subboardLength = widget.subboardLength;
    return Center(
      child: AspectRatio(
        aspectRatio: 1,
        child: AnimatedContainer(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(2),
          margin: EdgeInsets.all(widget.margin),
          duration: TRANSITION_DURATION,
          curve: Curves.ease,
          onEnd: () {
            widget.onEnd?.call();
          },
          child: Column(
            children: List.generate(
              5,
              (i) => Row(
                children:
                    List.generate(5, (j) => itemBuilder(i, j, subboardLength)),
                mainAxisAlignment: MainAxisAlignment.spaceAround,
              ),
            ),
            mainAxisAlignment: MainAxisAlignment.spaceAround,
          ),
        ),
      ),
    );
  }

  Widget itemBuilder(int row, int col, double subboardLength) {
    const int count = SudokuBoard.numberOfPartialColumns;
    if ((row == 1 || row == 3) && (col == 1 || col == 3)) {
      return Container(height: 3, width: 3);
    } else if (row == 1 || row == 3) {
      return Container(
          height: 3, width: subboardLength - 2, color: PRIMARY_COLOR[300]!);
    } else if (col == 1 || col == 3) {
      return Container(
          height: subboardLength - 2, width: 3, color: PRIMARY_COLOR[300]!);
    }
    int num = (row / 2).floor() * count + (col / 2).floor();
    return SudokuBoardSubgrid(
      length: subboardLength / 3.3,
      subboard: widget.currentBoard.subboard1D(num),
      notesSubboard: widget.currentBoard.notesSubboard1D(num),
      onPress: (j) =>
          widget.onPress((num ~/ 3) * 3 + j ~/ 3, (num % 3) * 3 + j % 3),
      buildDisplayColor: (j) =>
          _cellTextColor((num ~/ 3) * 3 + j ~/ 3, (num % 3) * 3 + j % 3),
      buildBackgroundColor: (j) =>
          _cellBackgroundColor((num ~/ 3) * 3 + j ~/ 3, (num % 3) * 3 + j % 3),
    );
  }
}
