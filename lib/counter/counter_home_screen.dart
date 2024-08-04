import 'package:provider_vs_riverpod/counter/provider_counter_widget.dart';
import 'package:provider_vs_riverpod/counter/riverpod_counter_widget.dart';
import 'package:provider_vs_riverpod/list/list_screen.dart';
import 'package:provider_vs_riverpod/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;

class CounterHomeScreen extends StatelessWidget {
  const CounterHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('build CounterHomeScreen');
    // //* This is an example of using provider to toggle theme
    final themeNotifier = provider.Provider.of<ThemeChangeNotifier>(context);
    final isDarkMode = themeNotifier.isDarkMode;
    final bannerNotifier = provider.Provider.of<BannerChangeNotifier>(context);
    final showBanner = bannerNotifier.showBanner;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Counter Example'),
          actions: [
            Row(
              children: [
                IconButton(
                  icon: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
                  onPressed: () {
                    themeNotifier.toggleTheme();
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
