import 'package:Taskbud/Utils/dateUtil.dart';
import 'package:Taskbud/Utils/global.dart';
import 'package:Taskbud/icons/task_bud_icon_icons.dart';
import 'package:Taskbud/models/task_model.dart';
import 'package:Taskbud/providers/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';

class UpdateTask extends StatefulWidget {
  final Tasks tasks;

  UpdateTask(this.tasks);

  @override
  _UpdateTaskState createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  final _formKey = GlobalKey<FormState>();
  String _taskName;
  String _taskDescription;
  String startTime;
  String endTime;
  String dateStart;
  String dateEnd;
  bool isComplete;
  bool isLoading;

  Future<void> _trySubmit() async {
    var isValid = _formKey.currentState.validate();
    if (startTime == null || endTime == null) {
      isValid = false;
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Date Cannot be Empty'),
          actions: <Widget>[
            FlatButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ),
      );
    }
    if (isValid) {
      setState(() {
        isLoading = true;
      });
      try {
        await Provider.of<TaskProvider>(context, listen: false).updateTask(
          _taskName,
          _taskDescription,
          !isComplete,
          dateStart,
          dateEnd,
          widget.tasks.taskId,
        );
        Navigator.of(context).pop();
      } catch (e) {
        print(e);
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('An error occurred!'),
            content: Text('Something went wrong.'),
            actions: <Widget>[
              FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              )
            ],
          ),
        );
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    isComplete = widget.tasks.completed;
    startTime =
        DateUtil().dateformatDefault(DateTime.parse(widget.tasks.startTime));
    endTime =
        DateUtil().dateformatDefault(DateTime.parse(widget.tasks.endTime));
    dateStart = DateTime.parse(widget.tasks.startTime).toIso8601String();
    dateEnd = DateTime.parse(widget.tasks.endTime).toIso8601String();
    _taskName = widget.tasks.taskName ?? "";
    _taskDescription = widget.tasks.description ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5.0,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  initialValue: _taskName,
                  decoration: InputDecoration(
                    prefixIcon: Icon(TaskBudIcon.taskname),
                    border: OutlineInputBorder(
                      borderSide: textFieldBorderSide,
                      borderRadius: textFieldBorderRadius,
                    ),
                    labelText: 'Task-Name',
                    labelStyle: hintStyle,
                  ),
                  validator: (value) {
                    if (value.isEmpty || value == null) {
                      return "Task-Name can't be empty";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _taskName = value;
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  initialValue: _taskDescription,
                  decoration: InputDecoration(
                    prefixIcon: Icon(TaskBudIcon.description),
                    border: OutlineInputBorder(
                      borderSide: textFieldBorderSide,
                      borderRadius: textFieldBorderRadius,
                    ),
                    labelText: 'Task-Description',
                    labelStyle: hintStyle,
                  ),
                  onChanged: (value) {
                    _taskDescription = value;
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Task Completed ...?",
                      style: secondaryHeader.copyWith(fontSize: 20),
                    ),
                    IconButton(
                      icon: isComplete
                          ? Icon(TaskBudIcon.complete)
                          : Icon(TaskBudIcon.hourglass_2),
                      onPressed: () {
                        setState(() {
                          isComplete = !isComplete;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text("Start Time :"),
                SizedBox(
                  height: 10.0,
                ),
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(width: 1.0),
                    ),
                    alignment: Alignment.center,
                    child: startTime == null
                        ? Text("Start Time")
                        : Text(startTime),
                  ),
                  onTap: () {
                    DatePicker.showDateTimePicker(
                      context,
                      showTitleActions: true,
                      onConfirm: (date) {
                        print("CURRENT TIME $date");
                        setState(() {
                          dateStart = date.toIso8601String();
                          startTime = DateUtil().dateformatDefault(date);
                        });
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text("End Time :"),
                SizedBox(
                  height: 10.0,
                ),
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(width: 1.0),
                    ),
                    alignment: Alignment.center,
                    child: endTime == null ? Text("End Time") : Text(endTime),
                  ),
                  onTap: () {
                    DatePicker.showDateTimePicker(
                      context,
                      showTitleActions: true,
                      minTime: DateTime.parse(dateStart) ?? DateTime.now(),
                      onConfirm: (date) {
                        print("CURRENT TIME $date");
                        dateEnd = date.toIso8601String();
                        setState(() {
                          endTime = DateUtil().dateformatDefault(date);
                        });
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 16.0,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  width: double.infinity,
                  child: RaisedButton(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Text(
                      "Update Task",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    onPressed: _trySubmit,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
