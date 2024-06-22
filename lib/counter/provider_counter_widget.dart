import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_app_state/counter/counter_state.dart';

class ProviderCounterWidget extends StatelessWidget {
  const ProviderCounterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Consumer<CounterChangeNotifier>(
            builder: (context, counter, child) {
              return Text('Provider Count: ${counter.count}');
            },
          ),
          FloatingActionButton(
            heroTag: "btn1",
            onPressed: () {
              context.read<CounterChangeNotifier>().increment();
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
