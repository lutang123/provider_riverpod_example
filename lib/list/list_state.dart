import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//* example of NOT using provider  with ChangeNotifier *******************************************************************************************************************
class ListChangeNotifier extends ChangeNotifier {
  final List<String> _items = [];
  List<String> get items => _items;

  void addItem(String item) {
    _items.add(item);
    notifyListeners();
  }
}

//* example of using riverpod with StateNotifier *******************************************************************************************************************

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
