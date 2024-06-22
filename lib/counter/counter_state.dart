import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// * example of using riverpod with StateNotifier *******************************************************************************************************************
class CounterStateNotifier extends StateNotifier<int> {
  CounterStateNotifier() : super(0);

  void increment() => state++;
}

//riverpod provider is global, so it can be accessed from anywhere in the app
final counterProvider =
    StateNotifierProvider<CounterStateNotifier, int>((ref) {
  return CounterStateNotifier();
});

// * example of using provider with ChangeNotifier *******************************************************************************************************************
class CounterChangeNotifier extends ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

//* example of NOT using provider or any package *******************************************************************************************************************
class CounterInheritedNotifier
    extends InheritedNotifier<CounterChangeNotifier> {
  const CounterInheritedNotifier({
    super.key,
    required super.child,
    required super.notifier,
  });

  static CounterInheritedNotifier? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<CounterInheritedNotifier>();
  }
}
