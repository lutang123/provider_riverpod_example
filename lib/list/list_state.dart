import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

final listProvider =
    StateNotifierProvider<ListStateNotifier, List<String>>((ref) {
  return ListStateNotifier();
});




