import 'package:flutter/material.dart';
import '../constants.dart';
import '../model/sudoku_symbol.dart';
import '../widget/primitive/simple_button.dart';

class SudokuInputButtons extends StatelessWidget {
  final bool inputtingNotes;
  final SudokuSymbol? selectedSymbol;
  final void Function(SudokuSymbol symbol) onPressSymbol;
  final void Function() onChangeInputMethod;

  const SudokuInputButtons({
    this.inputtingNotes = false,
    this.selectedSymbol,
    required this.onPressSymbol,
    required this.onChangeInputMethod,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: SudokuSymbols.symbols
              .sublist(1, 6)
              .map((s) => SimpleButton(
                    width: 50,
                    height: 50,
                    backgroundColor: s == selectedSymbol
                        ? CONTRAST_COLOR[900]
                        : Colors.transparent,
                    child: Text(
                      s.text,
                      style: TextStyle(
                        color: s == selectedSymbol
                            ? TERTIARY_COLOR[50]
                            : CONTRAST_COLOR[900],
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    borderRadius: 0,
                    border: Border.all(color: CONTRAST_COLOR[900]!),
                    onTap: () => onPressSymbol(s),
                  ))
              .toList(),
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        ),
        Row(
          children: SudokuSymbols.symbols
                  .sublist(6)
                  .map((s) => SimpleButton(
                        width: 50,
                        height: 50,
                        backgroundColor: s == selectedSymbol
                            ? CONTRAST_COLOR[900]
                            : Colors.transparent,
                        child: Text(
                          s.text,
                          style: TextStyle(
                            color: s == selectedSymbol
                                ? TERTIARY_COLOR[50]
                                : CONTRAST_COLOR[900],
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        borderRadius: 0,
                        border: Border.all(color: CONTRAST_COLOR[900]!),
                        onTap: () => onPressSymbol(s),
                      ))
                  .toList() +
              [
                SimpleButton(
                  width: 50,
                  height: 50,
                  child: Text(
                    "X",
                    style: TextStyle(
                      color: CONTRAST_COLOR[900],
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  borderRadius: 0,
                  border: Border.all(color: CONTRAST_COLOR[900]!),
                  onTap: () => onPressSymbol(SudokuSymbols.empty),
                )
              ],
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        ),
        Center(
          child: SimpleButton(
            width: 100,
            backgroundColor:
                inputtingNotes ? CONTRAST_COLOR : Colors.transparent,
            onTap: onChangeInputMethod,
            highlightColor: CONTRAST_COLOR[100],
            child: Icon(
              inputtingNotes ? Icons.edit : Icons.edit_off,
              color: inputtingNotes ? CONTRAST_COLOR[50] : CONTRAST_COLOR,
            ),
          ),
        )
      ],
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    );
  }
}
