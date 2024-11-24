class Task {
  String? title;
  String? description;
  String? addedOn;
  String? deadline;

  Task({
    this.title,
    this.description,
    this.addedOn,
    this.deadline,
  });

  Task copyWith({
    String? title,
    String? description,
    String? addedOn,
    String? deadline,
  }) =>
      Task(
        title: title ?? this.title,
        description: description ?? this.description,
        addedOn: addedOn ?? this.addedOn,
        deadline: deadline ?? this.deadline,
      );

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        title: json["title"],
        description: json["description"],
        addedOn: json["addedOn"],
        deadline: json["deadline"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "addedOn": addedOn,
        "deadline": deadline,
      };
}
