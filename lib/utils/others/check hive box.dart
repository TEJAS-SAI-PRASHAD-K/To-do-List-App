import 'dart:developer';

import 'package:hive/hive.dart';

import '../../models/user.dart';

void checkUserInHive() async {
  final box = await Hive.openBox<User>('todoTasks');

  // Retrieve data by key
  final user = box.get('FIRSTUSER');
  if (user != null) {
    log('User found in Hive: ${user.toString()}');
  } else {
    log('No user found with the key "FIRSTUSER".');
  }

  // Alternatively, print all data in the box
  log('All data in Hive: ${box.toMap()}');
}
