import 'dart:async';
import 'package:flutter/material.dart';

class TaskDeadlineManager {
  static TaskDeadlineManager? _instance;
  Timer? _refreshTimer;

  factory TaskDeadlineManager() {
    _instance ??= TaskDeadlineManager._internal();
    return _instance!;
  }

  TaskDeadlineManager._internal();

  String calculateRemainingTime(String deadlineMs) {
    int deadline = int.tryParse(deadlineMs) ?? 0;
    int now = DateTime.now().millisecondsSinceEpoch;
    int difference = deadline - now;

    if (difference <= 0) return 'Overdue';

    Duration remainingTime = Duration(milliseconds: difference);

    if (remainingTime.inDays > 0) {
      return '${remainingTime.inDays} Days';
    } else if (remainingTime.inHours > 0) {
      return '${remainingTime.inHours} hr';
    } else if (remainingTime.inMinutes > 0) {
      return '${remainingTime.inMinutes} min';
    } else {
      return 'Expiring soon';
    }
  }

  bool isTaskOverdue(String deadlineMs) {
    int deadline = int.tryParse(deadlineMs) ?? 0;
    return DateTime.now().millisecondsSinceEpoch > deadline;
  }
}

mixin TaskDeadlineRefreshMixin<T extends StatefulWidget> on State<T> {
  final TaskDeadlineManager _deadlineManager = TaskDeadlineManager();

  void onDeadlineRefresh() {
    // Override this method in your widget to implement specific refresh logic
    setState(() {});
  }
}
