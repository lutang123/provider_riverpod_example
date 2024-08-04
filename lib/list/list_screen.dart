import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:provider_vs_riverpod/list/provider_list_widget.dart';
import 'package:provider_vs_riverpod/list/riverpod_list_widget.dart';
import 'package:provider_vs_riverpod/main.dart';
import 'package:provider_vs_riverpod/todos/presentation/todo_screen.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('build ListScreen');
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('List Example'),
          actions: [
            //*This is an example of using riverpod to toggle theme
            Consumer(builder: (context, ref, _) {
              final isDarkMode = ref.watch(themeStateNotifierProvider);
              final themeStateNotifier =
                  ref.read(themeStateNotifierProvider.notifier);

              final showBanner = ref.watch(bannerNotifierProvider);
              final bannerNotifier = ref.read(bannerNotifierProvider.notifier);
              return Row(
                children: [
                  IconButton(
                    icon: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
                    onPressed: () {
                      themeStateNotifier.toggleTheme();
                    },
                  ),
                  const SizedBox(width: 20),
                  IconButton(
                    icon: Icon(showBanner
                        ? Icons.display_settings_outlined
                        : Icons.disabled_by_default_outlined),
                    onPressed: () {
                      bannerNotifier.toggleBanner();
                    },
                  ),
                ],
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
              builder: (context) => Theme(
                data: ThemeData.light(),
                child: const TodoScreen(),
              ),
            ),
          ),
          child: const Icon(Icons.arrow_forward),
        ),
      ),
    );
  }
}
