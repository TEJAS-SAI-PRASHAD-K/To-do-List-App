import 'package:first_1_flutter_application/pages/add_task_page.dart';
import 'package:first_1_flutter_application/utils/hive/boxes.dart';
import 'package:first_1_flutter_application/widgets/to_do_tile.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import '../models/user.dart';
import '../utils/others/check hive box.dart';
import '../widgets/theme_switch_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (builder) => const AddTaskPage()));
        },
        child: const Icon(Icons.add),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            expandedHeight: 250,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(children: [Text(DateFormat('EEEE').format(today))]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            "${today.day}.${today.month}\n${DateFormat('MMM').format(today).toUpperCase()}",
                            style: TextStyle(
                              fontSize: 52,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16), // Add spacing
                        height: 80, // Adjust height as needed
                        width: 1, // Thickness of the line
                        color: Colors.black,
                      ),
                      const Column(
                        children: [
                          Text("NewYork"),
                          SizedBox(
                            height: 12,
                          ),
                          Text("1.24"),
                          Text("NewYork"),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          ValueListenableBuilder<Box<User>>(
            valueListenable: Boxes.getUser().listenable(),
            builder: (context, box, _) {
              if (box.isEmpty) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 200), // Add desired height here
                        Text(
                          "No tasks added yet!!",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                );
              }

              // Safely get the first user
              final user = box.values.first;
              final tasks = user.tasks;

              // Check if tasks are null or empty
              if (tasks == null || tasks.isEmpty) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 200), // Add desired height here
                        Text(
                          "No tasks added yet!!",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                );
              }
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final task = tasks[index];
                    return ToDoTile(
                      task: task,
                    );
                  },
                  childCount: tasks.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
