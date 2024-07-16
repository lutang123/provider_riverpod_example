import 'package:sample_app_state/counter/counter_home_screen.dart';
import 'package:sample_app_state/counter/counter_state.dart';
import 'package:sample_app_state/list/list_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    ProviderScope(
      child:
          //* having both ProviderScope and Provides is not good, but this is just to show example on the differences of provider vs riverpod

          provider.MultiProvider(
        providers: [
          provider.ChangeNotifierProvider<CounterChangeNotifier>(
              create: (_) => CounterChangeNotifier()),
          provider.ChangeNotifierProvider<ListChangeNotifier>(
              create: (_) => ListChangeNotifier()),
          provider.ChangeNotifierProvider<BannerChangeNotifier>(
              create: (_) => BannerChangeNotifier()),
          provider.ChangeNotifierProvider<ThemeChangeNotifier>(
              create: (_) => ThemeChangeNotifier()),
        ],
        child:
            // * this is just to show how to use the old ChangeNotifierProvider with Provider package
            //  can not write this: final themeNotifier = Provider.of<ThemeChangeNotifier>(context);
            //   provider.Consumer<BannerChangeNotifier>(
            //       builder: (context, bannerNotifier, _) {
            // return provider.Consumer<ThemeChangeNotifier>(
            //     builder: (context, themeNotifier, _) {
            //* The above nested Consumer is just to show how to use the old ChangeNotifierProvider with Provider package
            // return

            Consumer(
          builder: (context, WidgetRef ref, _) {
            final isDarkModeStateNotifier =
                ref.watch(themeStateNotifierProvider);
            final showBanner = ref.watch(bannerNotifierProvider);

            return MaterialApp(
              debugShowCheckedModeBanner:
                  // bannerNotifier.showBanner,
                  showBanner,
              theme:
                  // themeNotifier.isDarkMode
                  isDarkModeStateNotifier
                      ? ThemeData.dark()
                      : ThemeData.light(),
              home: const CounterHomeScreen(),
            );
          },
        ),
      ),
    ),
  );
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
class BannerNotifier extends Notifier<bool> {
  @override
  bool build() => false; // initial state

  void toggleBanner() {
    state = !state;
  }
}

final bannerNotifierProvider =
    NotifierProvider<BannerNotifier, bool>(BannerNotifier.new);

// * Using ChangeNotifier with Provider package * //
class ThemeChangeNotifier extends ChangeNotifier {
  bool _isDarkMode = true;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}

class BannerChangeNotifier extends ChangeNotifier {
  bool _showBanner = false;

  bool get showBanner => _showBanner;

  void toggleBanner() {
    _showBanner = !_showBanner;
    notifyListeners();
  }
}
