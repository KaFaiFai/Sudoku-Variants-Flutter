import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constants.dart';
import 'routes.dart';
import 'state/board_state.dart';
import 'state/ui_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BoardState()),
        ChangeNotifierProvider(create: (_) => UIState()),
      ],
      child: MaterialApp(
        title: 'Sudoku',
        theme: ThemeData(
          primaryColor: PRIMARY_COLOR[900],
          colorScheme: const ColorScheme.dark(secondary: CONTRAST_COLOR),
          scaffoldBackgroundColor: PRIMARY_COLOR[900],
        ),
        onGenerateTitle: (_) => "Sudoku Game",
        initialRoute: RouteGenerator.homePage,
        onGenerateRoute: RouteGenerator.generateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
