import 'dart:convert';

import 'package:Taskbud/api/addTask/addTaskApi.dart';
import 'package:Taskbud/api/dashboard/getTask.dart';
import 'package:Taskbud/models/task_add_model.dart';
import 'package:Taskbud/models/task_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskProvider with ChangeNotifier {
  List<Tasks> _tasks = [];
  String authToken;
  TaskProvider(this.authToken, this._tasks);

  List<Tasks> get tasks {
    return [..._tasks];
  }

  int get tasklength {
    return _tasks.length;
  }

  Future<void> fetchTasks() async {
    try {
      List<Tasks> tasks = [];
      TaskModel taskModel = await DashBoardApi().getTaskList(authToken);
      taskModel.tasks.isEmpty
          ? tasks = []
          : taskModel.tasks.forEach((element) {
              tasks.add(element);
            });
      _tasks = tasks;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> addTask(
    String taskName,
    String taskDescription,
    bool completed,
    String startTime,
    String endTime,
  ) async {
    try {
      Map<String, dynamic> payload = {
        "task_name": taskName,
        "description": taskDescription ?? "",
        "completed": completed ?? false,
        "start_time": startTime,
        "end_time": endTime,
      };
      print(payload);
      TaskAddModel taskAddModel =
          await AddTaskApi().addTask(authToken, payload);
      if (taskAddModel.message == "Success") {
        print("SUCEESS");
      }
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
