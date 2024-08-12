import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_vs_riverpod/list/list_state.dart';

class ProviderListWidget extends StatelessWidget {
  const ProviderListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    print('build ProviderListWidget');
    return Column(
      children: [
        Expanded(
          child: Consumer<ListChangeNotifier>(
            builder: (context, itemNotifier, child) {
              final items = itemNotifier.items;
              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  print('build ListTile ${index + 1} in ProviderListWidget');
                  return ListTile(title: Text('${index + 1}. ${items[index]}'));
                },
              );
            },
          ),
        ),
        const Divider(),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: ProviderAddItemButton(),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class ProviderAddItemButton extends StatelessWidget {
  const ProviderAddItemButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              context
                  .read<ListChangeNotifier>()
                  .addItem('Provider Item ${DateTime.now()}');
            },
            child: const Text('Add Item'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              wrongFunction(context);
            },
            child: const Text('Wrong Button'),
          ),
        ],
      ),
    );
  }

  void wrongFunction(BuildContext context) {
    // No notifyListeners() called, so widgets listening to the state are not updated
    //* if we remover the type of itemNotifier, the complier will not complain
    final itemNotifier = context.read<ListChangeNotifier>();
    //* provider can access and attempting to change the state (items) in other widget, this is a wrong way to update the state, but complier will not complain
    itemNotifier.items.add('Untracked Item'); // Directly modifying the state
  }
}
