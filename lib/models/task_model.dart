import 'package:flutter/cupertino.dart';

class TaskModel {
  List<Tasks> tasks;

  TaskModel({this.tasks});

  TaskModel.fromJson(Map<String, dynamic> json) {
    if (json['tasks'] != null && json['tasks'] != []) {
      tasks = new List<Tasks>();
      json['tasks'].forEach((v) {
        tasks.add(new Tasks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tasks != null) {
      data['tasks'] = this.tasks.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tasks {
  int id;
  String userid;
  String taskId;
  String taskName;
  String description;
  bool completed;
  String startTime;
  String endTime;

  Tasks(
      {this.id,
      this.userid,
      this.taskId,
      this.taskName,
      this.description,
      this.completed,
      this.startTime,
      this.endTime});

  Tasks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userid = json['userid'];
    taskId = json['task_id'];
    taskName = json['task_name'];
    description = json['description'];
    completed = json['completed'];
    startTime = json['start_time'];
    endTime = json['end_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userid'] = this.userid;
    data['task_id'] = this.taskId;
    data['task_name'] = this.taskName;
    data['description'] = this.description;
    data['completed'] = this.completed;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    return data;
  }
}
