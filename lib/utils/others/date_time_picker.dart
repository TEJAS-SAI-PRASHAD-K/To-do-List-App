import 'package:flutter/material.dart';

Future<DateTime?> pickDateTime(
  BuildContext context, DateTime initialDateTime) async {
  DateTime? date = await showDatePicker(
    context: context,
    initialDate: initialDateTime,
    firstDate: DateTime(1900),
    lastDate: DateTime(2100),
  );
  if (date == null) return null;

  TimeOfDay? time = await showTimePicker(
    context: context,
    initialTime:
        TimeOfDay(hour: initialDateTime.hour, minute: initialDateTime.minute),
  );
  if (time == null) return null;

  return DateTime(date.year, date.month, date.day, time.hour, time.minute);
}
