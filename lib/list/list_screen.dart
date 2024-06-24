import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_app_state/list/add_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:sample_app_state/list/provider_list_widget.dart';
import 'package:sample_app_state/list/riverpod_list_widget.dart';
import 'package:sample_app_state/main.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('List Example'),
          actions: [
            //*This is an example of using StateNotifierProvider to toggle theme
            Consumer(builder: (context, ref, _) {
              final themeStateNotifier =
                  ref.read(themeStateNotifierProvider.notifier);
              return IconButton(
                icon: const Icon(Icons.brightness_6),
                onPressed: () {
                  themeStateNotifier.toggleTheme();
                },
              );
            }),
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
            ProviderListWidget(),
            RiverpodListWidget(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: "btn list",
          backgroundColor: Colors.deepPurpleAccent,
          onPressed: () => Navigator.of(context).push<void>(
            MaterialPageRoute<void>(
              builder: (context) => const AddListScreen(),
            ),
          ),
          child: const Icon(Icons.arrow_forward),
        ),
      ),
    );
  }
}
