import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_app_state/list/list_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart' as provider;
import 'package:sample_app_state/main.dart';

class AddListScreen extends StatelessWidget {
  const AddListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = provider.Provider.of<ThemeNotifier>(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add List Example'),
          actions: [
            IconButton(
              icon: const Icon(Icons.brightness_6),
              onPressed: () {
                themeNotifier.toggleTheme();
              },
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Provider'),
              Tab(text: 'Riverpod'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ProviderAddWidget(),
            RiverpodAddWidget(),
          ],
        ),
      ),
    );
  }
}

class ProviderAddWidget extends StatelessWidget {
  const ProviderAddWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            context
                .read<ListChangeNotifier>()
                .addItem('New Item ${DateTime.now()}');
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
    );
  }

  void wrongFunction(BuildContext context) {
    // No notifyListeners() called, so widgets listening to the state are not updated
    //* if we remover the type of itemNotifier, the complier will not complain
    final itemNotifier = context.read<ListChangeNotifier>();
    //this is a wrong way to update the state, but complier will not complain
    itemNotifier.items.add('Untracked Item'); // Directly modifying the state
  }
}

//* example of a widget that uses Riverpod
class RiverpodAddWidget extends ConsumerWidget {
  const RiverpodAddWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listNotifier = ref.read(listProvider.notifier);
    return Center(
      child: ElevatedButton(
        onPressed: () {
          // riverpod is type safe, so you can't directly modify the state
          listNotifier.addItem('Item ${DateTime.now()}');
        },
        child: const Text('Add Item'),
      ),
    );
  }
}
