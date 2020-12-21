import 'package:Taskbud/api/api_call.dart';
import 'package:Taskbud/models/http_exception.dart';
import 'package:Taskbud/models/login_response.dart';
import 'package:Taskbud/models/task_model.dart';

class DashBoardApi {
  Future<TaskModel> getTaskList(String auth) async {
    final url = "task/";
    var data = await ApiCall().getCallAuth(url, auth);
    if (data["error"] != null) {
      print(data["error"]);
      var loginResponse = LoginResponse.fromJson(data["error"]);
      throw HttpException(loginResponse.message);
    }
    Map<String, dynamic> output = data["result"];
    print(data["result"]);
    TaskModel taskModel = TaskModel.fromJson(output);
    print(taskModel.tasks[0].id);
    return taskModel;
  }
}
