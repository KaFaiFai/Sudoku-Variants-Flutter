import 'package:flutter/material.dart';
import 'constants.dart';
import 'model/sudoku_puzzle.dart';
import 'model/sudoku_variation.dart';
import 'route/home_page.dart';
import 'route/game_page.dart';
import 'route/level_select_page.dart';
import 'route/icon_page.dart';
import 'route/variation_select_page.dart';

class RouteGenerator {
  static const homePage = '/';
  static const variationSelectPage = '/variation_select';
  static const levelSelectPage = '/level_select';
  static const gamePage = '/game';
  static const iconPage = '/icon';

  RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePage:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => HomePage(),
          transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c),
          transitionDuration: TRANSITION_DURATION,
        );
      case variationSelectPage:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => VariationSelectPage(),
          transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c),
          transitionDuration: TRANSITION_DURATION,
        );
      case levelSelectPage:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) =>
              LevelSelectPage(variation: settings.arguments as SudokuVariation),
          transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c),
          transitionDuration: TRANSITION_DURATION,
        );
      case gamePage:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) =>
              GamePage(puzzle: settings.arguments as SudokuPuzzle),
          transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c),
          transitionDuration: TRANSITION_DURATION,
        );
      case iconPage:
        return MaterialPageRoute(builder: (_) => IconPage());
      default:
        throw const FormatException("Route not found");
    }
  }
}
