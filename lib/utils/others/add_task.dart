import 'package:first_1_flutter_application/models/task.dart';
import 'package:first_1_flutter_application/models/user.dart';

import 'boxes.dart';

void addTask(Task task) {
  final user = User();
  List<Task>? userTasks = user.tasks;
  if (userTasks == null) {
    userTasks = [];
    userTasks.add(task);
  } else {
    userTasks.add(task);
  }

  final box = Boxes.getUser();
  box.put('FIRSTUSER',user);
}
