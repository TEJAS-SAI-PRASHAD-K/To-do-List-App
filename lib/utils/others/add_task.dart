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
