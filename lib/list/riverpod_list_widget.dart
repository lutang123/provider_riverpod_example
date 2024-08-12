import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider_vs_riverpod/list/list_state.dart';

class RiverpodListWidget extends ConsumerWidget {
  const RiverpodListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('build RiverpodListWidget');
    final items = ref.watch(listProviderWithStateNotifier);

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              print('build ListTile ${index + 1} in RiverpodListWidget');
              return ListTile(title: Text('${index + 1}. ${items[index]}'));
            },
          ),
        ),
        const Divider(),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: RiverpodAddItemButton(),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class RiverpodAddItemButton extends ConsumerWidget {
  const RiverpodAddItemButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listNotifier = ref.read(listProviderWithStateNotifier.notifier);
    return Center(
      child: ElevatedButton(
        onPressed: () {
          // riverpod is type safe, so you can't directly modify the state
          listNotifier.addItem('Riverpod Item ${DateTime.now()}');
        },
        child: const Text('Add Item'),
      ),
    );
  }
}
