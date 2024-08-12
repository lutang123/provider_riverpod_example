import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'counter_state.g.dart';

// * example of using provider package with ChangeNotifier *******************************************************************************************************************
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

// * example of using riverpod package with StateNotifier *******************************************************************************************************************
class CounterStateNotifier extends StateNotifier<int> {
  CounterStateNotifier() : super(0);

  void increment() => state++;
}

//riverpod provider is global, so it can be accessed from anywhere in the app
final counterProviderWithStateNotifier = StateNotifierProvider<CounterStateNotifier, int>((ref) {
  return CounterStateNotifier();
});

// * example of using the riverpod 2.0 Notifier *******************************************************************************************************************
class CounterNotifier extends Notifier<int> {
  @override
  int build() {
    return 0;
  }

  void increment() {
    state++;
  }
}

final counterProviderWithNotifier =
    NotifierProvider<CounterNotifier, int>(() {
  return CounterNotifier();
});

final counterProviderNotifierProvider2 =
    NotifierProvider<CounterNotifier, int>(CounterNotifier.new);


// * example of riverpod 2.0 Notifier code generation *******************************************************************************************************************
/// Annotating a class by `@riverpod` defines a new shared state for your application,
// return the initial state of your shared state
//It is totally acceptable for this function to return a [Future] or [Stream] if you need to
//You can also freely define parameters on this method.
@riverpod
class Counter extends _$Counter {
  @override
  int build() => 0;

  void increment() => state++;
}
//above code will generate counterProvider, run "flutter pub run build_runner watch" on Terminal to generate the code



class CounterWidget2 extends ConsumerWidget {
  const CounterWidget2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. watch the provider and rebuild when the value changes
    final counter = ref.watch(counterProviderWithStateNotifier);
    return ElevatedButton(
      // 2. use the value
      child: Text('Value: $counter'),
      // 3. change the state inside a button callback
      onPressed: () => ref.read(counterProviderWithStateNotifier.notifier).increment,
    );
  }
}

//* example of using StateProvider *******************************************************************************************************************
final _counterStateProvider = StateProvider<int>((ref) => 0);

class MyApp2 extends ConsumerWidget {
  const MyApp2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(_counterStateProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('StateProvider Example')),
      body: Center(
        child: Text('Count: $counter'),
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
