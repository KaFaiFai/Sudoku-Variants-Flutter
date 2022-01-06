import 'package:flutter/material.dart';
import '../constants.dart';
import '../model/sudoku_variation.dart';
import '../routes.dart';
import '../widget/primitive/simple_button.dart';

class VariationSelectPage extends StatelessWidget {
  VariationSelectPage({Key? key}) : super(key: key);
  final _allVariations = SudokuVariation.all;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select a variant"),
        backgroundColor: PRIMARY_COLOR[900],
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: _allVariations
              .map((e) => SimpleButton(
                    child: Text(
                      e.text,
                      style: TextStyle(color: TERTIARY_COLOR[50]!),
                    ),
                    border: Border.all(width: 1, color: TERTIARY_COLOR[50]!),
                    backgroundColor: PRIMARY_COLOR[900],
                    highlightColor: CONTRAST_COLOR,
                    onTap: () => Navigator.of(context).pushNamed(
                        RouteGenerator.levelSelectPage,
                        arguments: e),
                  ))
              .toList(),
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        ),
      ),
    );
  }
}
