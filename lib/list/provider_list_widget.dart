import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_app_state/list/list_state.dart';

class ProviderListWidget extends StatelessWidget {
  const ProviderListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Consumer<ListChangeNotifier>(
            builder: (context, itemNotifier, child) {
              return ListView.builder(
                itemCount: itemNotifier.items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                      title:
                          Text('${index + 1}. ${itemNotifier.items[index]}'));
                },
              );
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

class _AddItemButton extends StatelessWidget {
  const _AddItemButton();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          context.read<ListChangeNotifier>().addItem('Item ${DateTime.now()}');
        },
        child: const Text('Add Item'),
      ),
    );
  }

  // Somewhere else in your app
  void someFunction(BuildContext context) {
    final itemNotifier = context.read<ListChangeNotifier>();
    itemNotifier.items.add('Untracked Item'); // Directly modifying the state
    // No notifyListeners() called, so widgets listening to the state are not updated
  }
}
