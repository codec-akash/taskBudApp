import 'dart:io';

import 'package:Taskbud/models/login_response.dart';
import 'package:Taskbud/models/task_add_model.dart';
import 'package:Taskbud/models/task_model.dart';

import '../api_call.dart';

class AddTaskApi {
  Future<TaskAddModel> addTask(String auth, payload) async {
    final url = "task/addTask";
    var data = await ApiCall().postAuth(url, auth, payload);
    if (data["error"] != null) {
      print(data["error"]);
      var loginResponse = LoginResponse.fromJson(data["error"]);
      throw HttpException(loginResponse.message);
    }
    Map<String, dynamic> output = data["result"];
    print(data["result"]);
    TaskAddModel taskModel = TaskAddModel.fromJson(output);
    // print(taskModel.tasks[0].id);
    return taskModel;
  }
}
