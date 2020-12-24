import 'dart:convert';

import 'package:Taskbud/api/addTask/taskApi.dart';
import 'package:Taskbud/api/dashboard/getTask.dart';
import 'package:Taskbud/models/login_response.dart';
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

  Future<void> updateTask(
    String taskName,
    String taskDescription,
    bool completed,
    String startTime,
    String endTime,
    String taskId,
  ) async {
    final oldStatus = completed;
    completed = !completed;
    try {
      Map<String, dynamic> payload = {
        "task_name": taskName,
        "description": taskDescription ?? "",
        "completed": completed ?? false,
        "start_time": startTime,
        "end_time": endTime,
      };
      print(payload);
      LoginResponse loginResponse;
      loginResponse = await AddTaskApi().updateTask(
        authToken,
        payload,
        taskId,
      );
      if (loginResponse.message == "Success") {
        print("SUCEESS");
        Tasks task = _tasks.firstWhere((element) => element.taskId == taskId);
        task.completed = completed;
        _tasks[_tasks.indexWhere((element) => element.taskId == taskId)] = task;
      }
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
