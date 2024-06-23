// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:sample_app_state/counter/counter_home_screen.dart';
import 'package:sample_app_state/counter/counter_state.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      ChangeNotifierProvider<CounterChangeNotifier>(
        create: (_) => CounterChangeNotifier(),
        child: const MaterialApp(
          home: CounterHomeScreen(),
        ),
      ),
    );

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}

// //* ChangeNotifier Implementation
// class CounterNotifier extends ChangeNotifier {
//   int _count = 0;
//   int get count => _count;

//   void increment() {
//     _count++;
//     notifyListeners();
//   }
// }

// //* StateNotifier Implementation
// class CounterNotifier extends StateNotifier<int> {
//   CounterNotifier() : super(0);

//   void increment() => state++;
// }

// // Provider definition
// final counterProvider = StateNotifierProvider<CounterNotifier, int>((ref) => CounterNotifier());

// //* Testing the CounterScreen with StateNotifierProvider
// void main() {
//   testWidgets('Counter increments smoke test', (WidgetTester tester) async {
//     await tester.pumpWidget(
//       ProviderScope(
//         child: MaterialApp(
//           home: CounterScreen(),
//         ),
//       ),
//     );

//     expect(find.text('0'), findsOneWidget);
//     expect(find.text('1'), findsNothing);

//     await tester.tap(find.byIcon(Icons.add));
//     await tester.pump();

//     expect(find.text('0'), findsNothing);
//     expect(find.text('1'), findsOneWidget);
//   });
// }

//
// * Dependency Injection (DI) is a design pattern used to implement Inversion of Control for resolving dependencies. Instead of creating dependencies directly within a class, dependencies are provided to the class, making it more modular, testable, and easier to maintain.

// Benefits of DI:

// Decoupling: Makes code more modular by decoupling the creation of dependencies from their usage.
// Testability: Simplifies testing by allowing easy replacement of real dependencies with mocks or stubs.
// Flexibility: Enhances flexibility by enabling dynamic changing of dependencies.