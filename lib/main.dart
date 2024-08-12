import 'package:provider_vs_riverpod/counter/counter_home_screen.dart';
import 'package:provider_vs_riverpod/counter/counter_state.dart';
import 'package:provider_vs_riverpod/list/list_state.dart';
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
          //* isuue with provider package is that if we have two providers with the same type, it's hard to differentiate them
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
            provider.Consumer<BannerChangeNotifier>(
          builder: (context, bannerNotifier, _) {
            return provider.Consumer<ThemeChangeNotifier>(
              builder: (context, themeNotifier, _) {
                //* The above nested Consumer is just to show how to use the old ChangeNotifierProvider with Provider package
                return Consumer(
                  builder: (context, WidgetRef ref, _) {
                    final isDarkModeStateNotifier =
                        ref.watch(themeStateNotifierProvider);
                    final showBanner = ref.watch(bannerNotifierProvider);

                    return MaterialApp(
                      debugShowCheckedModeBanner:
                          // //*if using provider package, we should use bannerNotifier.showBanner
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
                );
              },
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
  //* issue with provider packages is that the state is mutable
  bool _isDarkMode = true;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    //* issue with provider package is that we have to call notifyListeners() manually and it's easy to forget
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

//* By using immutable state, it becomes a lot simpler to:
//compare previous and new state
//implement an undo-redo mechanism
//debug the application state

//* Why Not Use setState for Simple Local State?

//Using setState is perfectly fine for managing simple, local states such as showing or hiding a password. However, using StateProvider or other state management solutions can be beneficial for several reasons:

//Consistency: Using a state management solution like StateProvider helps maintain consistency across your application, especially as it grows.
//Testability: State management solutions often make it easier to test your logic separately from the UI.
//Scalability: As your app scales, it becomes easier to manage state changes and share states across different parts of your app.

//* Why Use Provider for Constants or Simple Functions?

//Using Provider for simple values or functions can seem redundant but offers several benefits:
//Dependency Injection: Easily inject dependencies like configurations, constants, or services throughout the widget tree.
//Mocking and Testing: Simplifies the process of mocking dependencies in tests.
//Consistency: Maintains a consistent approach to accessing dependencies and state throughout the app.

//The provider package allows you to inject the ValueNotifier (or any other notifier) into the widget tree, making it accessible via context. This promotes better separation of concerns and makes it easier to manage state in larger applications.
//using provider offers additional benefits in terms of structure, maintainability, and testability, especially as your app scales. 

//1. Scope and Accessibility
//Without Provider (Global ValueNotifier):

//You can declare ValueNotifier globally and access it anywhere in your app.
//However, this approach can lead to tightly coupled code and makes it harder to manage state in larger applications.

//2. Separation of Concerns

//3. Reusability
//Without Provider: Directly using a global ValueNotifier can work, but it doesn't promote reuse as effectively as provider.
// With Provider: By using provider, you can easily reuse the same state management logic across different parts of your app.

