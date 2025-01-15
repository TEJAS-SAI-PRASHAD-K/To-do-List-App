import 'dart:developer';

import 'package:first_1_flutter_application/models/task.dart';
import 'package:first_1_flutter_application/utils/others/add_task.dart';
import 'package:first_1_flutter_application/utils/others/date_time_picker.dart';
import 'package:flutter/material.dart';

class TasksBottomSheet extends StatefulWidget {
  final Task task;
  const TasksBottomSheet({super.key, required this.task});

  @override
  State<TasksBottomSheet> createState() => _TasksBottomSheetState();
}

class _TasksBottomSheetState extends State<TasksBottomSheet> {
  int? _labelsValue;
  late DateTime dateTime;
  late DateTime deadline;
  late TextEditingController _textController;
  late TextEditingController _textControllerDescription;
  late final bool taskCompleted = false;
  List<String> labels = [
    "Work",
    "Urgent",
    "Personal",
    "Home",
    "Health",
    "Others"
  ];

  @override
  void initState() {
    super.initState();

    // Initialize with the passed task's details
    _textController = TextEditingController(text: widget.task.title);
    _textControllerDescription =
        TextEditingController(text: widget.task.description);

    // Convert milliseconds to DateTime
    deadline =
        DateTime.fromMillisecondsSinceEpoch(int.parse(widget.task.deadline!));
    dateTime =
        DateTime.fromMillisecondsSinceEpoch(int.parse(widget.task.addedOn!));

    // Set the label value
    _labelsValue = labels.indexOf(widget.task.label!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        padding: const EdgeInsets.all(8),
                        style: IconButton.styleFrom(
                            side: BorderSide(
                                color: Theme.of(context).colorScheme.tertiary)),
                        icon: const Icon(
                          Icons.close_rounded,
                          size: 30,
                        )),
                    const Text(
                      "Edit Tasks",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        editTask(
                          Task(
                            uuid: widget.task.uuid,
                            title: _textController.text,
                            description: _textControllerDescription.text,
                            addedOn: widget.task
                                .addedOn, // Use the original addedOn timestamp
                            deadline:
                                deadline.millisecondsSinceEpoch.toString(),
                            taskCompleted: widget.task
                                .taskCompleted, // Preserve the original completed status
                            label: labels[_labelsValue!],
                          ),
                        );

                        log("task edited successfully");
                        Navigator.pop(context);
                      },
                      padding: const EdgeInsets.all(8),
                      style: IconButton.styleFrom(
                          side: BorderSide(
                              color: Theme.of(context).colorScheme.tertiary)),
                      icon: const Icon(
                        Icons.edit,
                        size: 30,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          deleteTask(
                            Task(
                              uuid: widget.task.uuid,
                            ),
                          );
                          Navigator.pop(context);
                        },
                        padding: const EdgeInsets.all(8),
                        style: IconButton.styleFrom(
                            side: BorderSide(
                                color: Theme.of(context).colorScheme.tertiary)),
                        icon: const Icon(
                          Icons.delete_outline_rounded,
                          size: 30,
                        )),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 10),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 16, 0, 8),
                child: Text(
                  "Deadline",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () async {
                          final DateTime? deadlineDateTime = await pickDateTime(
                              context, dateTime); // Call the picker
                          if (deadlineDateTime != null) {
                            setState(() {
                              deadline = deadlineDateTime; // Update the state
                            });
                          }
                        },
                        padding: const EdgeInsets.all(8),
                        style: IconButton.styleFrom(
                            shape: const CircleBorder(),
                            side: BorderSide(
                                color: Theme.of(context).colorScheme.tertiary)),
                        icon: const Padding(
                          padding: EdgeInsets.fromLTRB(2, 0, 0, 2),
                          child: Icon(
                            Icons.more_time_rounded,
                            size: 30,
                          ),
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        '${deadline.year}/${deadline.month}/${deadline.day} '
                        '${deadline.hour}:${deadline.minute}',
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w300),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 10),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 16, 0, 8),
                child: Text(
                  "Labels",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 50, // Set a fixed height for the horizontal ListView
                child: ListView.builder(
                  scrollDirection:
                      Axis.horizontal, // Make the ListView horizontal
                  itemCount: 6,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0), // Optional spacing
                      child: ChoiceChip(
                        checkmarkColor: Theme.of(context).colorScheme.surface,
                        selectedColor: Theme.of(context).colorScheme.primary,
                        disabledColor: Theme.of(context).colorScheme.surface,
                        label: Text(
                          labels[index],
                          style: TextStyle(
                            color: _labelsValue == index
                                ? Theme.of(context).colorScheme.surface
                                : Theme.of(context).colorScheme.primary,
                            fontSize: 16,
                          ),
                        ),
                        selected: _labelsValue == index,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        onSelected: (selected) {
                          setState(() {
                            _labelsValue = selected ? index : null;
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 10),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 16, 0, 8),
                child: Text(
                  "Title",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: ValueListenableBuilder<TextEditingValue>(
                      valueListenable:
                          _textController, // Using _textController for first TextField
                      builder: (context, value, child) {
                        return TextField(
                          controller: _textController,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                                color: Theme.of(context).colorScheme.tertiary),
                            hintText: "Enter a Task",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            suffixIcon: value.text.isNotEmpty
                                ? IconButton(
                                    icon: Icon(
                                      Icons.close_rounded,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                    ),
                                    onPressed: () {
                                      _textController
                                          .clear(); // Clear _textController
                                    },
                                  )
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                    child: ValueListenableBuilder<TextEditingValue>(
                      valueListenable: _textControllerDescription,
                      builder: (context, value, child) {
                        return TextField(
                          controller: _textControllerDescription,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                                color: Theme.of(context).colorScheme.tertiary),
                            hintText: "Description (Optional)",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            suffixIcon: value.text.isNotEmpty
                                ? IconButton(
                                    icon: Icon(
                                      Icons.close_rounded,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                    ),
                                    onPressed: () {
                                      _textControllerDescription.clear();
                                    },
                                  )
                                : null,
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            // SliverToBoxAdapter(
            //   child: BottomAppBar(
            //     child: TextButton(
            //       onPressed: () {
            //         addTask(Task(
            //           title: _textController.text,
            //           description: _textControllerDescription.text,
            //           addedOn: DateTime.now().millisecondsSinceEpoch.toString(),
            //           deadline: deadline.millisecondsSinceEpoch.toString(),
            //           taskCompleted: taskCompleted,
            //           label: labels[_labelsValue!],
            //         ));

            //         log("task added successfully");
            //         Navigator.pop(context);
            //       },
            //       style: TextButton.styleFrom(
            //           backgroundColor: Theme.of(context).colorScheme.primary),
            //       child: Text(
            //         "Create",
            //         style: TextStyle(
            //             color: Theme.of(context).colorScheme.surface,
            //             fontSize: 20),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
