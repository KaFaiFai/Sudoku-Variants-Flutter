import 'package:flutter/material.dart';
import '../constants.dart';
import '../model/sudoku_puzzle.dart';
import '../widget/sudoku_board_grid.dart';
import '../widget/sudoku_puzzle_info.dart';

class SudokuPuzzlesTabs extends StatefulWidget {
  final List<SudokuPuzzle> puzzles;
  final double gridMargin;
  final double infoOpacity;
  final double subboardLength;
  void Function(SudokuPuzzle) onTap;
  void Function(SudokuPuzzle) onAnimationEnd;

  SudokuPuzzlesTabs({
    required this.puzzles,
    this.gridMargin = LARGE_MARGIN,
    this.infoOpacity = 1.0,
    required this.subboardLength,
    required this.onTap,
    required this.onAnimationEnd,
    Key? key,
  }) : super(key: key);

  @override
  State<SudokuPuzzlesTabs> createState() => _SudokuPuzzlesTabsState();
}

class _SudokuPuzzlesTabsState extends State<SudokuPuzzlesTabs>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;
  late List<Widget> tabViews;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: widget.puzzles.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    tabViews = widget.puzzles.map((p) => buildTabViews(context, p)).toList();
    return TabBarView(controller: tabController, children: tabViews);
  }

  Widget buildTabViews(BuildContext context, SudokuPuzzle puzzle) {
    return Column(
      children: [
        Expanded(
          flex: 7,
          child: SudokuBoardGrid(
            initialBoard: puzzle.initialBoard,
            currentBoard: puzzle.savedBoard ?? puzzle.initialBoard,
            variation: puzzle.variation,
            onPress: (_, __) {},
            margin: widget.gridMargin,
            subboardLength: widget.subboardLength,
            onEnd: () => widget.onAnimationEnd(puzzle),
          ),
        ),
        Expanded(
          flex: 3,
          child: SudokuPuzzleInfo(
            puzzle: puzzle,
            onPress: (puzzle) => widget.onTap(puzzle),
            opacity: widget.infoOpacity,
          ),
        ),
      ],
    );
  }
}
