import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 2)
class Task {
  @HiveField(1)
  String? uuid;
  @HiveField(2)
  String? title;
  @HiveField(3)
  String? description;
  @HiveField(4)
  String? addedOn;
  @HiveField(5)
  String? deadline;
  @HiveField(6)
  bool? taskCompleted;
  @HiveField(7)
  String? label;

  Task({
    this.uuid,
    this.title,
    this.description,
    this.addedOn,
    this.deadline,
    this.taskCompleted,
    this.label,
  });

  Task copyWith({
    String? uuid,
    String? title,
    String? description,
    String? addedOn,
    String? deadline,
    bool? taskCompleted,
    String? label,
  }) =>
      Task(
        uuid: uuid ?? this.uuid,
        title: title ?? this.title,
        description: description ?? this.description,
        addedOn: addedOn ?? this.addedOn,
        deadline: deadline ?? this.deadline,
        taskCompleted: taskCompleted ?? this.taskCompleted,
        label: label ?? this.label,
      );

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        uuid: json["uuid"],
        title: json["title"],
        description: json["description"],
        addedOn: json["addedOn"],
        deadline: json["deadline"],
        taskCompleted: json["taskCompleted"],
        label: json["label"],
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "title": title,
        "description": description,
        "addedOn": addedOn,
        "deadline": deadline,
        "taskCompleted": taskCompleted,
        "label": label,
      };
}
