class TaskAddModel {
  String message;
  Result result;

  TaskAddModel({this.message, this.result});

  TaskAddModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class Result {
  int id;
  String userid;
  String taskId;
  String taskName;
  String description;
  bool completed;
  String startTime;
  String endTime;

  Result(
      {this.id,
      this.userid,
      this.taskId,
      this.taskName,
      this.description,
      this.completed,
      this.startTime,
      this.endTime});

  Result.fromJson(Map<String, dynamic> json) {
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
