import 'dart:developer';

import 'package:first_1_flutter_application/utils/others/add_task.dart';
import 'package:first_1_flutter_application/utils/others/date_time_picker.dart';
import 'package:flutter/material.dart';

import '../models/task.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  int? _dayValue = 1;
  int? _suggestionValue;
  int? _labelsValue;
  DateTime dateTime = DateTime.now();
  DateTime deadline = DateTime.now();
  late TextEditingController _textController = TextEditingController();
  late TextEditingController _textControllerDescription =
      TextEditingController();
  late final bool taskCompleted = false;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _textControllerDescription = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    _textControllerDescription.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> days = ["Today", "Tomorrow"];
    List<String> suggestions = [
      "Complete Assignments",
      "Schedule a Doctor Appointment",
      "Send a Birthday Card",
      "Go for a Jog",
      "Schedule Team Meeting"
    ];
    List<String> labels = [
      "Work",
      "Urgent",
      "Personal",
      "Home",
      "Health",
      "Others"
    ];
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: IconButton(
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
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "New Task",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 50, // Set a fixed height for the horizontal ListView
                child: ListView.builder(
                  scrollDirection:
                      Axis.horizontal, // Make the ListView horizontal
                  itemCount: 2,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0), // Optional spacing
                      child: ChoiceChip(
                        checkmarkColor: Theme.of(context).colorScheme.surface,
                        selectedColor: Theme.of(context).colorScheme.primary,
                        disabledColor: Theme.of(context).colorScheme.surface,
                        label: Text(
                          days[index],
                          style: TextStyle(
                            color: _dayValue == index
                                ? Theme.of(context).colorScheme.surface
                                : Theme.of(context).colorScheme.primary,
                            fontSize: 18,
                          ),
                        ),
                        selected: _dayValue == index,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        onSelected: (selected) {
                          setState(() {
                            _dayValue = selected ? index : null;
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 12),
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
              child: SizedBox(height: 12),
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
              child: SizedBox(height: 12),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 16, 0, 8),
                child: Text(
                  "Suggestions",
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
                  itemCount: 5,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0), // Optional spacing
                      child: ChoiceChip(
                        checkmarkColor: Theme.of(context).colorScheme.surface,
                        selectedColor: Theme.of(context).colorScheme.primary,
                        disabledColor: Theme.of(context).colorScheme.surface,
                        label: Text(
                          suggestions[index],
                          style: TextStyle(
                            color: _suggestionValue == index
                                ? Theme.of(context).colorScheme.surface
                                : Theme.of(context).colorScheme.primary,
                            fontSize: 16,
                          ),
                        ),
                        selected: _suggestionValue == index,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        onSelected: (selected) {
                          setState(() {
                            _suggestionValue = selected ? index : null;
                            _textController.text =
                                selected ? suggestions[index] : "";
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 12),
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
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
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
            SliverToBoxAdapter(
              child: BottomAppBar(
                child: TextButton(
                  onPressed: () {
                    addTask(Task(
                      title: _textController.text,
                      description: _textControllerDescription.text,
                      addedOn: DateTime.now().millisecondsSinceEpoch.toString(),
                      deadline: deadline.millisecondsSinceEpoch.toString(),
                      taskCompleted: taskCompleted,
                      label: labels[_labelsValue!],
                    ));

                    log("task added successfully");
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary),
                  child: Text(
                    "Create",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.surface,
                        fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
