import 'package:sample_app_state/counter/counter_home_screen.dart';
import 'package:sample_app_state/counter/counter_state.dart';
import 'package:sample_app_state/list/list_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    ProviderScope(
      //* not good practice, but just to show example on the differences of provider vs riverpod
      child: provider.MultiProvider(
        providers: [
          provider.ChangeNotifierProvider<CounterChangeNotifier>(
              create: (_) => CounterChangeNotifier()),
          provider.ChangeNotifierProvider<ListChangeNotifier>(
              create: (_) => ListChangeNotifier()),
          provider.ChangeNotifierProvider(create: (_) => ThemeNotifier()),
        ],
        child: provider.Consumer<ThemeNotifier>(
            builder: (context, themeNotifier, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme:
                themeNotifier.isDarkMode ? ThemeData.dark() : ThemeData.light(),
            home: const CounterHomeScreen(),
          );
        }),
      ),
    ),
  );
}

class ThemeNotifier extends ChangeNotifier {
  bool _isDarkMode = true;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}

//* example of using StateProvider *******************************************************************************************************************
final counterStateProvider = StateProvider<int>((ref) => 0);

class MyApp2 extends ConsumerWidget {
  const MyApp2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterStateProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('StateProvider Example')),
      body: Center(
        child: Text('Count: $count'),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "btn1",
        onPressed: () => ref.read(counterStateProvider.notifier).state++,
        child: const Icon(Icons.add),
      ),
    );
  }
}

//* example of using ValueNotifier *******************************************************************************************************************
final ValueNotifier<int> _counter = ValueNotifier<int>(0);

class MyApp3 extends StatelessWidget {
  const MyApp3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ValueNotifier Example')),
      body: ValueListenableBuilder<int>(
        valueListenable: _counter,
        builder: (context, count, child) {
          return Center(
            child: Text('Count: $count'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "btn1",
        onPressed: () => _counter.value++,
        child: const Icon(Icons.add),
      ),
    );
  }
}



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
