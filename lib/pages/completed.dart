import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/user.dart';
import '../utils/hive/boxes.dart';
import '../widgets/to_do_tile.dart';

class CompletedListPage extends StatelessWidget {
  const CompletedListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            title: const Text('Completed Tasks'),
            floating: true,
          ),
          ValueListenableBuilder<Box<User>>(
            valueListenable: Boxes.getUser().listenable(),
            builder: (context, box, _) {
              if (box.isEmpty) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: Text("No completed tasks"),
                  ),
                );
              }

              final user = box.values.first;
              final completedTasks = user.tasks
                      ?.where((task) => task.taskCompleted == true)
                      .toList() ??
                  [];

              if (completedTasks.isEmpty) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: Text("No completed tasks yet!"),
                  ),
                );
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final task = completedTasks[index];
                    return ToDoTile(task: task);
                  },
                  childCount: completedTasks.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
