class Task {
  String title;
  String description;
  String addedOn;
  String deadline;
  bool taskCompleted;

  Task({
    required this.title,
    required this.description,
    required this.addedOn,
    required this.deadline,
    required this.taskCompleted,
  });
  Task copyWith({
    String? title,
    String? description,
    String? addedOn,
    String? deadline,
    bool? taskCompleted,
  }) {
    return Task(
      title: title ?? this.title,
      description: description ?? this.description,
      addedOn: addedOn ?? this.addedOn,
      deadline: deadline ?? this.deadline,
      taskCompleted: taskCompleted ?? this.taskCompleted,
    );
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json["title"] ?? "",
      description: json["description"] ?? "",
      addedOn: json["addedOn"] ?? "",
      deadline: json["deadline"] ?? "",
      taskCompleted: json["taskCompleted"] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "addedOn": addedOn,
      "deadline": deadline,
      "taskCompleted": taskCompleted,
    };
  }
}
