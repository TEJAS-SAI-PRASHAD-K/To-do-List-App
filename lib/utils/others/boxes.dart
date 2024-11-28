import 'package:first_1_flutter_application/models/user.dart';
import 'package:hive/hive.dart';

class Boxes {
  static Box<User> getUser() => Hive.box<User>('todoTasks');
}
