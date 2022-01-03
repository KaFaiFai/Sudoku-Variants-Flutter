import 'package:flutter/material.dart';
import '../constants.dart';
import '../routes.dart';

class UIState extends ChangeNotifier {
  double _gridMargin = LARGE_MARGIN;
  double _infoOpacity = 1.0;
  bool _inTransition = false;
  String? _page;

  double get currentGridMargin => _gridMargin;
  double get currentInfoOpacity => _infoOpacity;
  bool get currentInTransition => _inTransition;
  String? get currentPage => _page;

  void reset() {
    _gridMargin = LARGE_MARGIN;
    _infoOpacity = 1.0;
    _inTransition = false;
    _page = null;
    notifyListeners();
  }

  void _transition() {
    _gridMargin = _gridMargin == LARGE_MARGIN ? SMALL_MARGIN : LARGE_MARGIN;
    _infoOpacity = _infoOpacity == 1.0 ? 0.0 : 1.0;
    _inTransition = true;
    notifyListeners();
  }

  void toGamePage([void Function()? callback]) {
    _gridMargin = SMALL_MARGIN;
    _infoOpacity = 0.0;
    _inTransition = true;
    callback?.call();
    _page = RouteGenerator.gamePage;
    notifyListeners();
  }

  void toSelectPage([void Function()? callback]) {
    _gridMargin = LARGE_MARGIN;
    _infoOpacity = 1.0;
    _inTransition = true;
    callback?.call();
    _page = RouteGenerator.levelSelectPage;
    notifyListeners();
  }

  void completeTransition() {
    _inTransition = false;
    notifyListeners();
  }
}
