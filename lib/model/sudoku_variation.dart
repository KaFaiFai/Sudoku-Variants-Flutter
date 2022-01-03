import '../model/sudoku_rule.dart';

class SudokuVariation {
  final String text;
  final SudokuRule rule;

  const SudokuVariation._(this.text, this.rule);

  static final SudokuVariation classic =
      SudokuVariation._("classic", classicRule);
  static final SudokuVariation antiKnight =
      SudokuVariation._("anti-knight", antiKnightRule);

  static final List<SudokuVariation> all = [
    classic,
    antiKnight,
  ];

  static SudokuVariation from(String s) {
    for (int i = 0; i < all.length; i++) {
      if (s == all[i].text) {
        return all[i];
      }
    }
    return classic;
  }
}
