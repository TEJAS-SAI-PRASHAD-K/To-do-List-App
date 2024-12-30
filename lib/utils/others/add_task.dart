import 'dart:developer';

import 'package:first_1_flutter_application/models/task.dart';
import 'package:first_1_flutter_application/models/user.dart';

import '../hive/boxes.dart';

void addTask(Task task) {
  // Access the Hive box for users
  final box = Boxes.getUser();

  // Retrieve the existing user from the box
  final user =
      box.get('FIRSTUSER') ?? User(); // If no user exists, create a new one

  // Access the user's task list
  List<Task> userTasks = user.tasks ?? [];

  // Add the new task to the list
  userTasks.add(task);

  // Update the user's tasks
  user.tasks = userTasks;

  // Save the updated user back to the box
  box.put('FIRSTUSER', user);
}

String convertMillisecondsToTime(int milliseconds) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(milliseconds);
  String formattedTime =
      "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  return formattedTime;
}

void editTask(Task task) {
  // Access the Hive box for users
  final box = Boxes.getUser();

  // Retrieve the existing user from the box
  final User user =
      box.get('FIRSTUSER') ?? User(); // If no user exists, create a new one

  // Access the user's task list
  List<Task> userTasks = user.tasks ?? [];

  for (int i = 0; i < userTasks.length; i++) {
    if (userTasks[i].addedOn == task.addedOn) {
      userTasks[i] = task; // Update the task in the list
    }
  }

  for (Task eachTask in userTasks) {
    log("Each task after update: ${eachTask.title} ${eachTask.label}");
  }

  // Update the user's tasks
  user.tasks = userTasks;

  // Save the updated user back to the box
  box.put('FIRSTUSER', user);
  
  log("Updated new task: ${task.description}, ${task.title}");
}
