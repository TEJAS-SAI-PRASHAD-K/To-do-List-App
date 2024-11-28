import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 2)
class Task {
  @HiveField(1)
  String? title;
  @HiveField(2)
  String? description;
  @HiveField(3)
  String? addedOn;
  @HiveField(4)
  String? deadline;
  @HiveField(5)
  bool? taskCompleted;
  @HiveField(6)
  String? label;

  Task({
    this.title,
    this.description,
    this.addedOn,
    this.deadline,
    this.taskCompleted,
    this.label,
  });

  Task copyWith({
    String? title,
    String? description,
    String? addedOn,
    String? deadline,
    bool? taskCompleted,
    String? label,
  }) =>
      Task(
        title: title ?? this.title,
        description: description ?? this.description,
        addedOn: addedOn ?? this.addedOn,
        deadline: deadline ?? this.deadline,
        taskCompleted: taskCompleted ?? this.taskCompleted,
        label: label ?? this.label,
      );

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        title: json["title"],
        description: json["description"],
        addedOn: json["addedOn"],
        deadline: json["deadline"],
        taskCompleted: json["taskCompleted"],
        label: json["label"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "addedOn": addedOn,
        "deadline": deadline,
        "taskCompleted": taskCompleted,
        "label": label,
      };
}
