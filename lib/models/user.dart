import 'dart:convert';
import 'task.dart';


User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String? username;
  List<Task>? tasks;

  User({
    this.username,
    this.tasks,
  });

  User copyWith({
    String? username,
    List<Task>? tasks,
  }) =>
      User(
        username: username ?? this.username,
        tasks: tasks ?? this.tasks,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        tasks: json["tasks"] == null
            ? []
            : List<Task>.from(json["tasks"]!.map((x) => Task.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "tasks": tasks == null
            ? []
            : List<dynamic>.from(tasks!.map((x) => x.toJson())),
      };
}
