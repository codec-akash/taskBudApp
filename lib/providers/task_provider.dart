import 'package:Taskbud/api/dashboard/getTask.dart';
import 'package:Taskbud/models/task_model.dart';
import 'package:flutter/cupertino.dart';

class TaskProvider with ChangeNotifier {
  List<Tasks> _tasks = [];
  String authToken;
  TaskProvider(this.authToken, this._tasks);

  List<Tasks> get tasks {
    return [..._tasks];
  }

  Future<void> fetchTasks() async {
    try {
      List<Tasks> tasks = [];
      TaskModel taskModel = await DashBoardApi().getTaskList(authToken);
      taskModel.tasks.forEach((element) {
        tasks.add(element);
      });
      _tasks = tasks;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
