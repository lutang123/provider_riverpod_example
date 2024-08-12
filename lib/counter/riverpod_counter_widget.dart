import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider_vs_riverpod/counter/counter_state.dart';

class RiverpodCounterWidget extends ConsumerWidget {
  const RiverpodCounterWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('build RiverpodCounterWidget');

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Consumer(
            builder: (context, ref, child) {
              //**Note: counterProvider is a generated provider and by default with Auto dispose, so everytime when we reload the page, the count value is always set at 0 */
              final count = ref.watch(counterProvider);
              print('build Text in RiverpodCounterWidget: $count');
              return Text('Riverpod Count: $count');
            },
          ),
          FloatingActionButton(
            heroTag: "btn2",
            onPressed: () {
              ref.read(counterProvider.notifier).increment();
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
