import 'package:hive/hive.dart';
import 'dart:convert';
import 'task.dart';

part 'user.g.dart';


User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

@HiveType(typeId: 1)
class User {
    @HiveField(1)
    String? username;
    @HiveField(2)
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
        tasks: json["tasks"] == null ? [] : List<Task>.from(json["tasks"]!.map((x) => Task.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "tasks": tasks == null ? [] : List<dynamic>.from(tasks!.map((x) => x.toJson())),
    };
}