import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'list_state.g.dart';

//* example of using provider package with ChangeNotifier *******************************************************************************************************************
class ListChangeNotifier extends ChangeNotifier {
  final List<String> _items = [];
  List<String> get items => _items;

  void addItem(String item) {
    _items.add(item);
    notifyListeners();
  }
}

//* example of using riverpod with StateNotifier *//
//* StateNotifier is a replacement for ChangeNotifier or ValueNotifier)
//The purpose of StateNotifier is to be a simple solution to control state in an immutable manner.
// While ChangeNotifier is simple, through its mutable nature, it can be harder to maintain as it grows larger.

//* using immutable model classes we can enforce a unidirectional data flow
//* Immutable state and sealed unions
class ListStateNotifier extends StateNotifier<List<String>> {
  ListStateNotifier() : super([]);

  void addItem(String item) {
    state = [...state, item]; // Creating a new state
  }
}

final listProviderWithStateNotifier =
    StateNotifierProvider<ListStateNotifier, List<String>>((ref) {
  return ListStateNotifier();
});

//* example of using the riverpod 2.0 Notifier *******************************************************************************************************************
// // Step 1: Extend `Notifier` instead of `StateNotifier`
class ListNotifier extends Notifier<List<String>> {
  // Step 2: Implement the `build` method
  @override
  List<String> build() {
    return []; // Initial state
  }

  void addItem(String item) {
    state = [...state, item]; // Updating the state
  }
}

// Step 3: Change `StateNotifierProvider` to `NotifierProvider`
final listProviderWithNotifier = NotifierProvider<ListNotifier, List<String>>(() {
  return ListNotifier();
});


//* example of riverpod 2.0 Notifier code generation *******************************************************************************************************************

// Step 0: Adde these imports on top of the file
//import 'package:riverpod_annotation/riverpod_annotation.dart';
//part 'list_notifier.g.dart'; 

// Step 1: Annotate the class with `@riverpod`
@riverpod
class ListNotifierGenerated extends _$ListNotifierGenerated {
  // Step 2: Implement the `build` method
  @override
  List<String> build() {
    return []; // Initial state
  }

  void addItem(String item) {
    state = [...state, item]; // Updating the state
  }
}
//above code will generate listNotifierGeneratedProvider, run "flutter pub run build_runner watch" on Terminal to generate the code