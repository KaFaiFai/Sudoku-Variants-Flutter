class SudokuSymbol {
  final String text;
  final int code;

  const SudokuSymbol({required this.text, required this.code});
}

class SudokuSymbols {
  SudokuSymbols._();
  
  static const empty = SudokuSymbol(text: " ", code: 0);
  static const one = SudokuSymbol(text: "1", code: 1);
  static const two = SudokuSymbol(text: "2", code: 2);
  static const three = SudokuSymbol(text: "3", code: 3);
  static const four = SudokuSymbol(text: "4", code: 4);
  static const five = SudokuSymbol(text: "5", code: 5);
  static const six = SudokuSymbol(text: "6", code: 6);
  static const seven = SudokuSymbol(text: "7", code: 7);
  static const eight = SudokuSymbol(text: "8", code: 8);
  static const nine = SudokuSymbol(text: "9", code: 9);

  static const symbols = [
    empty,
    one,
    two,
    three,
    four,
    five,
    six,
    seven,
    eight,
    nine
  ];

  static SudokuSymbol fromInt(int n) {
    if (1 <= n && n <= 9) return symbols[n];
    return symbols[0];
  }

  static SudokuSymbol from(String s) {
    for (var i = 1; i < symbols.length; i++) {
      if (s == symbols[i].text) return symbols[i];
    }
    return symbols[0];
  }
}
