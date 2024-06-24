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
          provider.ChangeNotifierProvider<ThemeChangeNotifier>(
              create: (_) => ThemeChangeNotifier()),
        ],
        child:
            // * this is just to show how to use the old ChangeNotifierProvider with Provider package
            provider.Consumer<ThemeChangeNotifier>(
                builder: (context, ThemeChangeNotifier themeNotifier, _) {
          //* this Consumer is from riverpod
          // return Consumer(builder: (context, WidgetRef ref, _) {
            //     //* this is the code to show the syntax with riverpod StateNotifier and Notifier

            // final isDarkModeStateNotifier =
            //     ref.watch(themeStateNotifierProvider);

            // final isDarkModeNotifier = ref.watch(themeNotifierProvider);

            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: themeNotifier.isDarkMode
                  ? ThemeData.dark()
                  : ThemeData.light(),

              //     //* this is the code to show the syntax with riverpod StateNotifier and Notifier
              //     isDarkModeStateNotifier // isDarkModeNotifier
              //         ? ThemeData.dark()
              //         : ThemeData.light(),
              home: const CounterHomeScreen(),
            );
          // });
        }),
      ),
    ),
  );
}

// * Using ChangeNotifier with Provider package * //
class ThemeChangeNotifier extends ChangeNotifier {
  bool _isDarkMode = true;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}

// * Using StateNotifier with Riverpod * //
class ThemeStateNotifier extends StateNotifier<bool> {
  ThemeStateNotifier() : super(true);

  void toggleTheme() {
    state = !state;
  }
}

final themeStateNotifierProvider =
    StateNotifierProvider<ThemeStateNotifier, bool>((ref) {
  return ThemeStateNotifier();
});

// * Using the new Notifier with Riverpod 2.0 * //
class ThemeNotifier extends Notifier<bool> {
  @override
  bool build() => true; // initial state is dark mode

  void toggleTheme() {
    state = !state;
  }
}

final themeNotifierProvider =
    NotifierProvider<ThemeNotifier, bool>(ThemeNotifier.new);
