import 'dart:convert';

import 'package:Taskbud/api/addTask/taskApi.dart';
import 'package:Taskbud/api/dashboard/getTask.dart';
import 'package:Taskbud/models/http_exception.dart';
import 'package:Taskbud/models/local_notification_model.dart';
import 'package:Taskbud/models/login_response.dart';
import 'package:Taskbud/models/task_add_model.dart';
import 'package:Taskbud/models/task_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskProvider with ChangeNotifier {
  List<Tasks> _tasks = [];
  String authToken;
  int completedTask;
  int incompletedTask;
  List<DateTime> notificationList = [];
  List<LocalNotificationModel> testNotify = [];

  TaskProvider(this.authToken, this._tasks);

  List<Tasks> get tasks {
    return [..._tasks];
  }

  int get tasklength {
    return _tasks.length;
  }

  int get completedLength {
    return completedTask;
  }

  int get inCompletedLength {
    return incompletedTask;
  }

  List get notificationTimeList {
    // return notificationList;
    return testNotify;
  }

  bool isComplete(int i) {
    return _tasks[i].completed;
  }

  Future<void> fetchTasks() async {
    try {
      List<Tasks> tasks = [];
      completedTask = 0;
      incompletedTask = 0;
      TaskModel taskModel = await DashBoardApi().getTaskList(authToken);
      taskModel.tasks.isEmpty
          ? tasks = []
          : taskModel.tasks.forEach((element) {
              tasks.add(element);
            });
      _tasks = tasks;
      tasks.forEach((element) {
        if (element.completed == true) {
          completedTask++;
        } else {
          incompletedTask++;
        }
      });
      print("in$incompletedTask");
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
        notificationList.add(DateTime.parse(startTime));
        LocalNotificationModel notify = LocalNotificationModel();
        notify.startTime = DateTime.parse(startTime);
        notify.message = taskName;
        testNotify.add(notify);
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
        Tasks task = _tasks.firstWhere((element) => element.taskId == taskId);
        task.completed = completed;
        task.taskName = taskName;
        task.description = taskDescription;
        task.startTime = startTime;
        task.endTime = endTime;
        _tasks[_tasks.indexWhere((element) => element.taskId == taskId)] = task;
      }
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> deleteTask(String taskId) async {
    final existingTaskIndex =
        _tasks.indexWhere((element) => element.taskId == taskId);
    var existingTask = _tasks[existingTaskIndex];
    _tasks.removeAt(existingTaskIndex);
    notifyListeners();
    LoginResponse loginResponse;
    loginResponse = await AddTaskApi().deleteTask(authToken, taskId);
    if (loginResponse.message != "Success") {
      _tasks.insert(existingTaskIndex, existingTask);
      notifyListeners();
      throw HttpException("Could not delete Task");
    }
    existingTask = null;
  }
}
