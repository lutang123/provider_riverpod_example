import 'package:flutter/material.dart';
import 'package:provider_vs_riverpod/list/provider_list_widget.dart';
import 'package:provider_vs_riverpod/list/riverpod_list_widget.dart';
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
