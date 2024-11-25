import 'package:hive/hive.dart';
import 'task.dart';
import 'user.dart';

void registerHiveAdapters() {
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(UserAdapter());
}
