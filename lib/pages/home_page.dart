import 'package:first_1_flutter_application/pages/add_task_page.dart';
import 'package:first_1_flutter_application/utils/hive/boxes.dart';
import 'package:first_1_flutter_application/widgets/to_do_tile.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/standalone.dart' as tz;

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
  late String formattedIndiaTime;
  late String formattedUkTime;

  @override
  void initState() {
    super.initState();
    // Initialize timezone data
    tz.initializeTimeZones();

    // Get Indian timezone location
    final indiaTimeZone = tz.getLocation('Asia/Kolkata');
    final ukTimezone = tz.getLocation('Europe/London');

    // Get current date and time in the Indian timezone
    final indiaTime = tz.TZDateTime.now(indiaTimeZone);
    final ukTime = tz.TZDateTime.now(ukTimezone);

    // Format the time to HH:mm a
    final formatter = DateFormat('hh:mm a');
    formattedIndiaTime = formatter.format(indiaTime);
    formattedUkTime = formatter.format(ukTime);
  }

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
            expandedHeight: 280,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding:
                  const EdgeInsets.only(left: 16.0, right: 16, bottom: 50.0),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Row(children: [
                      Text(
                        DateFormat('EEEE').format(today),
                        style: const TextStyle(fontSize: 14),
                      )
                    ]),
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              "${today.day}.${today.month}\n${DateFormat('MMM').format(today).toUpperCase()}",
                              style: TextStyle(
                                fontSize: 52,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 18), // Add spacing
                          height: 75, // Adjust height as needed
                          width: 0.7, // Thickness of the line
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            formattedIndiaTime,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const Text(
                            "New Delhi",
                            style: TextStyle(fontSize: 10),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            formattedUkTime,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const Text(
                            "United Kingdom",
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0),
              child: Container(
                height: 32,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
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
