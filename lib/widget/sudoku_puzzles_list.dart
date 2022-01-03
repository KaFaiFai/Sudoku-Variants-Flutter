import 'package:flutter/material.dart';
import '../constants.dart';
import '../model/sudoku_puzzle.dart';

class SudokuPuzzlesView extends StatelessWidget {
  final List<SudokuPuzzle> puzzles;
  final void Function(SudokuPuzzle) onTap;

  const SudokuPuzzlesView({
    this.puzzles = const [],
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green, width: 3),
      ),
      child: ListView.separated(
        itemCount: puzzles.length,
        itemBuilder: (context, i) => Column(
          children: [
            const SizedBox(height: 30),
            InkWell(
              child: ListTile(
                title: Text("Sudoku ${puzzles[i].id}"),
                subtitle: Text("${puzzles[i].difficulty}⭐\n"
                    "${puzzles[i].variation.text}"),
                isThreeLine: true,
                trailing: puzzles[i].hasWon ? const Icon(Icons.done) : null,
              ),
              onTap: () => onTap(puzzles[i]),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              highlightColor: ACCENT_COLOR[200],
            ),
            const SizedBox(height: 30),
          ],
        ),
        separatorBuilder: (_, __) => Container(height: 1, color: Colors.green),
      ),
    );
  }
}
