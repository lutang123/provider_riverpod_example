import 'package:sample_app_state/counter/counter_home_screen.dart';
import 'package:sample_app_state/counter/counter_state.dart';
import 'package:sample_app_state/list/list_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    ProviderScope(
      //* not good practice, but just to show example on the differences of provider vs riverpod
      child: provider.MultiProvider(
        providers: [
          provider.ChangeNotifierProvider<CounterChangeNotifier>(
              create: (_) => CounterChangeNotifier()),
          provider.ChangeNotifierProvider<ListChangeNotifier>(
              create: (_) => ListChangeNotifier()),
          provider.ChangeNotifierProvider(create: (_) => ThemeNotifier()),
        ],
        child: provider.Consumer<ThemeNotifier>(
            builder: (context, themeNotifier, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme:
                themeNotifier.isDarkMode ? ThemeData.dark() : ThemeData.light(),
            home: const CounterHomeScreen(),
          );
        }),
      ),
    ),
  );
}

class ThemeNotifier extends ChangeNotifier {
  bool _isDarkMode = true;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
