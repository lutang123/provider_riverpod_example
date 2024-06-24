import 'package:sample_app_state/counter/provider_counter_widget.dart';
import 'package:sample_app_state/counter/riverpod_counter_screen.dart';
import 'package:sample_app_state/list/list_screen.dart';
import 'package:sample_app_state/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;

class CounterHomeScreen extends StatelessWidget {
  const CounterHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = provider.Provider.of<ThemeChangeNotifier>(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Counter Example'),
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
            ProviderCounterWidget(),
            RiverpodCounterWidget(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: "btn counter",
          backgroundColor: Colors.deepPurpleAccent,
          onPressed: () => Navigator.of(context).push<void>(
            MaterialPageRoute<void>(
              builder: (context) => const ListScreen(),
            ),
          ),
          child: const Icon(Icons.arrow_forward),
        ),
      ),
    );
  }
}
