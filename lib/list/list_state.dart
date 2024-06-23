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


// By using immutable state, it becomes a lot simpler to:
//compare previous and new state
//implement an undo-redo mechanism
//debug the application state
//Why Not Use setState for Simple Local State?

//Using setState is perfectly fine for managing simple, local states such as showing or hiding a password. However, using StateProvider or other state management solutions can be beneficial for several reasons:

//Consistency: Using a state management solution like StateProvider helps maintain consistency across your application, especially as it grows.
//Testability: State management solutions often make it easier to test your logic separately from the UI.
//Scalability: As your app scales, it becomes easier to manage state changes and share states across different parts of your app.

//Why Use Provider for Constants or Simple Functions?
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

// final _counterValueNotifier = ValueNotifier<int>(0);

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: Text('Global ValueNotifier Example')),
//         body: Center(
//           child: ValueListenableBuilder<int>(
//             valueListenable: _counterValueNotifier,
//             builder: (context, count, child) {
//               return Text('Count: $count');
//             },
//           ),
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () => _counterValueNotifier.value++,
//           child: Icon(Icons.add),
//         ),
//       ),
//     );
//   }
// }

// class MyWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Consumer<ValueNotifier<int>>(
//           builder: (context, counterNotifier, child) {
//             return Text('Count: ${counterNotifier.value}');
//           },
//         ),
//         ElevatedButton(
//           onPressed: () => context.read<ValueNotifier<int>>().value++,
//           child: Text('Increment'),
//         ),
//       ],
//     );
//   }
// }
