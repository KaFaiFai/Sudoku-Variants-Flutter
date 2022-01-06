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

class _TestPageState extends State<TestPage> {
  final widthLength = 8.0;

  @override
  Widget build(BuildContext context) {
    final margin = 50.0;
    final subboardLength =
        (MediaQuery.of(context).size.width - (margin + widthLength) * 2 - 4) /
            3;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sudoku Test'),
      ),
      body: Center(
        child: AspectRatio(
          aspectRatio: 1,
          child: AnimatedContainer(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(2),
            margin: EdgeInsets.all(margin),
            duration: TRANSITION_DURATION,
            curve: Curves.ease,
            onEnd: () {},
            child: Column(
              children: List.generate(
                5,
                (i) => Row(
                  children: List.generate(
                      5, (j) => itemBuilder(i, j, subboardLength)),
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                ),
              ),
              mainAxisAlignment: MainAxisAlignment.spaceAround,
            ),
          ),
        ),
      ),
    );
  }

  Widget itemBuilder(int row, int col, double subboardLength) {
    const int count = 3;
    if ((row == 1 || row == 3) && (col == 1 || col == 3)) {
      return Container(
        height: widthLength,
        width: widthLength,
        color: PRIMARY_COLOR[300]!,
      );
    } else if ((row == 1 || row == 3) && col == 0) {
      return Container(
        height: widthLength,
        width: subboardLength,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.horizontal(
            left: Radius.elliptical(10, 10),
          ),
          color: PRIMARY_COLOR[300]!,
        ),
      );
    } else if ((row == 1 || row == 3) && col == 4) {
      return Container(
        height: widthLength,
        width: subboardLength,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.horizontal(
            right: Radius.elliptical(10, 10),
          ),
          color: PRIMARY_COLOR[300]!,
        ),
      );
    } else if (row == 1 || row == 3) {
      return Container(
        height: widthLength,
        width: subboardLength,
        color: PRIMARY_COLOR[300]!,
      );
    } else if ((col == 1 || col == 3) && row == 0) {
      return Container(
        height: subboardLength,
        width: widthLength,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(
            top: Radius.elliptical(10, 10),
          ),
          color: PRIMARY_COLOR[300]!,
        ),
      );
    } else if ((col == 1 || col == 3) && row == 4) {
      return Container(
        height: subboardLength,
        width: widthLength,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.elliptical(10, 10),
          ),
          color: PRIMARY_COLOR[300]!,
        ),
      );
    } else if (col == 1 || col == 3) {
      return Container(
        height: subboardLength,
        width: widthLength,
        color: PRIMARY_COLOR[300]!,
      );
    }
    int num = (row / 2).floor() * count + (col / 2).floor();
    final chars = ["S", "U", "D", " ", "K", "O", " ", " ", " "];
    return Container(
      child: Center(
          child: Text(chars[num],
              style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.w600,
                  color: TERTIARY_COLOR[50]))),
      width: subboardLength - 10,
      height: subboardLength - 10,
    );
  }
}
