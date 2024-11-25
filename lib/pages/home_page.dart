import 'package:first_1_flutter_application/pages/add_task_page.dart';
import 'package:first_1_flutter_application/widgets/to_do_tile.dart';
import 'package:flutter/material.dart';

import '../models/task.dart';
import '../widgets/theme_switch_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Task> tasks = [
    Task(
      title: "Complete Flutter project",
      description: "Finish the UI and integrate the backend APIs.",
      addedOn: "2024-11-20",
      deadline: "2024-11-30",
      taskCompleted: false,
      label: "Personal",
    ),
    Task(
      title: "Team meeting",
      description: "Discuss project roadmap and key deliverables.",
      addedOn: "2024-11-21",
      deadline: "2024-11-24",
      taskCompleted: true,
      label: "Work",
    ),
    Task(
      title: "Prepare presentation",
      description:
          "Create slides for the Suicide Prevention and Mental Health presentation.",
      addedOn: "2024-11-22",
      deadline: "2024-11-25",
      taskCompleted: false,
      label: "Work",
    ),
    Task(
      title: "Submit expense report",
      description:
          "Compile and submit the monthly expense report to the finance team.",
      addedOn: "2024-11-15",
      deadline: "2024-11-26",
      taskCompleted: true,
      label: "Work",
    ),
    Task(
      title: "Code review",
      description: "Review the pull requests and provide feedback.",
      addedOn: "2024-11-18",
      deadline: "2024-11-24",
      taskCompleted: false,
      label: "Urgent",
    ),
  ];

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
            backgroundColor: Theme.of(context).colorScheme.tertiary,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(70, 30),
                          padding: const EdgeInsets.all(0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        onPressed: () {},
                        child:
                            const Text("Today", style: TextStyle(fontSize: 10)),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(70, 30),
                          padding: const EdgeInsets.all(0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text("Tomorrow",
                            style: TextStyle(fontSize: 10)),
                      ),
                      IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          shape: const CircleBorder(),
                        ),
                        icon: Icon(
                          Icons.add,
                          color: Theme.of(context).colorScheme.primary,
                          size: 22,
                        ),
                        splashRadius: 30,
                        color: Colors.black,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => const AddTaskPage()));
                        },
                      ),
                      const ThemeSwitchButton(),
                    ],
                  ),
                  const Text("Tuesday"),
                ],
              ),
            ),
          ),
          SliverList.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final Task task = tasks[index];
              return ToDoTile(
                task: task,
              );
            },
          ),
        ],
      ),
    );
  }
}
