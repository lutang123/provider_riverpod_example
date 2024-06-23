import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// * example of using provider with ChangeNotifier *******************************************************************************************************************
// *** Flutter itself has two primary notifiers: ChangeNotifier and ValueNotifier ***
// *** A ChangeNotifier is a class that can be extended or mixed in to provide a change notification mechanism. It is commonly used for managing and notifying listeners about state changes.
class CounterChangeNotifier extends ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

// * example of using riverpod with StateNotifier *******************************************************************************************************************
class CounterStateNotifier extends StateNotifier<int> {
  CounterStateNotifier() : super(0);

  void increment() => state++;
}

//riverpod provider is global, so it can be accessed from anywhere in the app
final counterProvider = StateNotifierProvider<CounterStateNotifier, int>((ref) {
  return CounterStateNotifier();
});

// * example of using the new Notifier *******************************************************************************************************************
class CounterNotifier extends Notifier<int> {
  @override
  int build() {
    return 0;
  }

  void increment() {
    state++;
  }
}

final counterProviderNotifierProvider =
    NotifierProvider<CounterNotifier, int>(() {
  return CounterNotifier();
});

final counterProviderNotifierProvider2 =
    NotifierProvider<CounterNotifier, int>(CounterNotifier.new);

class CounterWidget extends ConsumerWidget {
  const CounterWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. watch the provider and rebuild when the value changes
    final counter = ref.watch(counterProvider);
    return ElevatedButton(
      // 2. use the value
      child: Text('Value: $counter'),
      // 3. change the state inside a button callback
      onPressed: () => ref.read(counterProvider.notifier).increment,
    );
  }
}

//* example of using StateProvider *******************************************************************************************************************
final _counterStateProvider = StateProvider<int>((ref) => 0);

class MyApp2 extends ConsumerWidget {
  const MyApp2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(_counterStateProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('StateProvider Example')),
      body: Center(
        child: Text('Count: $count'),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "btn1",
        onPressed: () => ref.read(_counterStateProvider.notifier).state++,
        child: const Icon(Icons.add),
      ),
    );
  }
}

//* example of using ValueNotifier *******************************************************************************************************************
//*** A ValueNotifier is a subclass of ChangeNotifier that holds a single value and notifies listeners when the value changes. It is simpler and more efficient for cases where you only need to manage a single value */

final _counterValueNotifier = ValueNotifier<int>(0);

class MyApp3 extends StatelessWidget {
  const MyApp3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ValueNotifier Example')),
      body: ValueListenableBuilder<int>(
        valueListenable: _counterValueNotifier,
        builder: (context, count, child) {
          return Center(
            child: Text('Count: $count'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "btn1",
        onPressed: () => _counterValueNotifier.value++,
        child: const Icon(Icons.add),
      ),
    );
  }
}

//* https://pub.dev/packages/provider#-readme-tab-
// ValueListenableProvider is removed

// To migrate, you can instead use Provider combined with ValueListenableBuilder:

// ValueListenableBuilder<int>(
//   valueListenable: myValueListenable,
//   builder: (context, value, _) {
//     return Provider<int>.value(
//       value: value,
//       child: MyApp(),
//     );
//   }
// )

// //* example of NOT using provider or any package *******************************************************************************************************************
// class CounterInheritedNotifier
//     extends InheritedNotifier<CounterChangeNotifier> {
//   const CounterInheritedNotifier({
//     super.key,
//     required super.child,
//     required super.notifier,
//   });

//   static CounterInheritedNotifier? of(BuildContext context) {
//     return context
//         .dependOnInheritedWidgetOfExactType<CounterInheritedNotifier>();
//   }
// }

// //* example of NOT using provider or any package *******************************************************************************************************************
// class MyApp2 extends StatelessWidget {
//   const MyApp2({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final CounterChangeNotifier counterNotifier = CounterChangeNotifier();

//     return CounterInheritedNotifier(
//       notifier: counterNotifier,
//       child: MaterialApp(
//         home: Scaffold(
//           appBar: AppBar(title: const Text('InheritedWidget Example')),
//           body: const Column(
//             children: [
//               Expanded(child: CounterDisplay2()),
//               Expanded(child: IncrementButton2()),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CounterDisplay2 extends StatelessWidget {
//   const CounterDisplay2({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final counterNotifier = CounterInheritedNotifier.of(context)!.notifier;
//     return Center(
//       child: CounterInheritedNotifier(
//         notifier: counterNotifier,
//         child: Text('Count: ${counterNotifier?.count}'),
//       ),
//     );
//   }
// }

// class IncrementButton2 extends StatelessWidget {
//   const IncrementButton2({super.key});

//   @override
//   Widget build(BuildContext context) {
//     print('IncrementButton rebuilt');
//     // final counterNotifier = CounterInheritedNotifier.of(context)!.notifier;
//     final counterNotifier = CounterInheritedNotifier.of(context)!.notifier;
//     return Center(
//       child: FloatingActionButton(
//         onPressed: () => counterNotifier?.increment(),
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
