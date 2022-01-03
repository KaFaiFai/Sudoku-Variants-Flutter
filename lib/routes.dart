import 'package:flutter/material.dart';
import 'constants.dart';
import 'model/sudoku_puzzle.dart';
import 'model/sudoku_variation.dart';
import 'route/home_page.dart';
import 'route/game_page.dart';
import 'route/level_select_page.dart';
import 'route/test_page.dart';
import 'route/variation_select_page.dart';

class RouteGenerator {
  static const homePage = '/';
  static const variationSelectPage = '/variation_select';
  static const levelSelectPage = '/level_select';
  static const gamePage = '/game';
  static const testPage = '/test';

  RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePage:
        return MaterialPageRoute(builder: (_) => HomePage());
      case variationSelectPage:
        return MaterialPageRoute(builder: (_) => VariationSelectPage());
      case levelSelectPage:
        return MaterialPageRoute(
            builder: (_) => LevelSelectPage(
                variation: settings.arguments as SudokuVariation));
      case gamePage:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) =>
              GamePage(puzzle: settings.arguments as SudokuPuzzle),
          transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c),
          transitionDuration: TRANSITION_DURATION,
        );
      case testPage:
        return MaterialPageRoute(builder: (_) => TestPage());
      default:
        throw const FormatException("Route not found");
    }
  }
}
