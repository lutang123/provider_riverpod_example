import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_app_state/list/list_state.dart';

class RiverpodListWidget extends ConsumerWidget {
  const RiverpodListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(listProvider);

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(title: Text('${index + 1}. ${items[index]}'));
            },
          ),
        ),
        const Divider(),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: _AddItemButton(),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class _AddItemButton extends ConsumerWidget {
  const _AddItemButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          ref.read(listProvider.notifier).addItem('Item ${DateTime.now()}');
        },
        child: const Text('Add Item'),
      ),
    );
  }
}
