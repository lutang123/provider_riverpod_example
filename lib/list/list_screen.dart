import 'package:sample_app_state/list/add_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;
import 'package:sample_app_state/list/provider_list_widget.dart';
import 'package:sample_app_state/list/riverpod_list_widget.dart';
import 'package:sample_app_state/main.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = provider.Provider.of<ThemeNotifier>(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('List Example'),
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
