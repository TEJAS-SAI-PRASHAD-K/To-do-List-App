import 'dart:math';

import 'package:first_1_flutter_application/utils/others/add_newline.dart';
import 'package:flutter/material.dart';
import '../models/task.dart';
import '../utils/hive/boxes.dart';
import 'deadline_time.dart';
import 'tasks_bottom_sheet.dart';

class ToDoTile extends StatefulWidget {
  final Task task;
  const ToDoTile({super.key, required this.task});

  @override
  State<ToDoTile> createState() => _ToDoTileState();
}

class _ToDoTileState extends State<ToDoTile> with TaskDeadlineRefreshMixin {
  final TaskDeadlineManager _deadlineManager = TaskDeadlineManager();

  @override
  void initState() {
    super.initState();
    backgroundColor = _pickRandomColor();
  }

  @override
  void onDeadlineRefresh() {
    // Refresh logic when lifecycle state changes
    setState(() {});
  }

  late Color backgroundColor;

  final List<Color> colorOptions = [
    const Color(0xFFE4B875), // #e4b875
    const Color(0xFFB0BBBC), // #b0bbbc
    const Color(0xFFBBB2CC), // #bbb2cc
    const Color(0xFFCB9CA3), // #cb9ca3
    const Color(0xFF9BCBC8), // #9bcbc8
    const Color(0xFFC0CB9C), // #c0cb9c
    const Color(0xFFA8C7D4), // #a8c7d4
  ];

  Color _pickRandomColor() {
    final random = Random();
    return colorOptions[random.nextInt(colorOptions.length)];
  }

  void taskCompletedStateSwitcher() {
    // Get the user box
    final userBox = Boxes.getUser();
    final user = userBox.values.first;

    setState(() {
      widget.task.taskCompleted = !widget.task.taskCompleted!;

      // Update the task in the user's tasks list
      // This triggers the ValueListenableBuilder to rebuild
      userBox.put('FIRSTUSER', user);
    });
  }

  String convertMillisecondsToTimeWithAMPM(int milliseconds) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(milliseconds);

    // Determine AM or PM
    String period = dateTime.hour >= 12 ? "PM" : "AM";

    // Convert to 12-hour format
    int hourIn12HourFormat = dateTime.hour % 12;
    if (hourIn12HourFormat == 0) {
      hourIn12HourFormat = 12; // Handle midnight (0) as 12
    }

    String formattedTime =
        "${hourIn12HourFormat.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')} $period";
    return formattedTime;
  }

  String convertMillisecondsToTime(int milliseconds) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    String formattedTime =
        "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
    return formattedTime;
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final addedOn =
        convertMillisecondsToTimeWithAMPM(int.parse(widget.task.addedOn!));

    final deadline =
        convertMillisecondsToTimeWithAMPM(int.parse(widget.task.deadline!));

    final timeDifference =
        _deadlineManager.calculateRemainingTime(widget.task.deadline!);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
      child: GestureDetector(
        onTap: () => showModalBottomSheet(
          // shape: const RoundedRectangleBorder(
          //     borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
          context: context,
          builder: (context) => TasksBottomSheet(task: widget.task),
        ),
        child: Container(
          height: 230,
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 16, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        addNewlines(widget.task.title!, 22),
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
                        child: IconButton(
                          onPressed: taskCompletedStateSwitcher,
                          icon: widget.task.taskCompleted!
                              ? const Icon(
                                  Icons.check_circle_outline_outlined,
                                  size: 30,
                                )
                              : const Icon(
                                  Icons.check,
                                  size: 30,
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            addedOn,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                          const Text(
                            "Start",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        child: Text(
                          timeDifference,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            deadline,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Text(
                            "End",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
