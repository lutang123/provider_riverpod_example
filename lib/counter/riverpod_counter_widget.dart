import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_app_state/counter/counter_state.dart';

class RiverpodCounterWidget extends ConsumerWidget {
  const RiverpodCounterWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('build RiverpodCounterWidget');
    final count = ref.watch(counterProvider);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text('Riverpod Count: $count'),
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
