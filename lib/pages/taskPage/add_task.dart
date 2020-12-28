import 'package:Taskbud/Utils/app_media_query.dart';
import 'package:Taskbud/Utils/dateUtil.dart';
import 'package:Taskbud/Utils/global.dart';
import 'package:Taskbud/icons/task_bud_icon_icons.dart';
import 'package:Taskbud/models/http_exception.dart';
import 'package:Taskbud/providers/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';

class AddTaskPage extends StatefulWidget {
  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  String _taskName;
  String _taskDescription;
  String startTime;
  String dateStart;
  String dateEnd;
  String endTime;

  Future<void> _trySubmit() async {
    var isValid = _formKey.currentState.validate();
    if (dateStart == null || dateEnd == null) {
      isValid = false;
      Scaffold.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).primaryColor,
          duration: Duration(seconds: 3),
          content: Text(
            "Date Cannot be empty",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );
    }
    if (isValid) {
      setState(() {
        isLoading = true;
      });
      try {
        await Provider.of<TaskProvider>(context, listen: false).addTask(
          _taskName,
          _taskDescription,
          false,
          dateStart,
          dateEnd,
        );
        Scaffold.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).primaryColor,
            duration: Duration(seconds: 3),
            content: Text(
              "Task Added",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        );
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      } on HttpException catch (error) {
        print("ONHTTP$error");
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      } catch (error) {
        print("ONCATCH$error");
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
        // _showErrorDialog(errorMessage);
      }
      _formKey.currentState.reset();
      startTime = null;
      endTime = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                child: Image.asset(
                  "images/addTask.png",
                  height: AppMediaQuery(context).appHeight(20.0),
                  alignment: Alignment.bottomRight,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
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
                  if (value.isEmpty) {
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
                height: 20.0,
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
                  child:
                      startTime == null ? Text("Start Time") : Text(startTime),
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
              isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      width: double.infinity,
                      child: RaisedButton(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Text(
                          "Add Task",
                          style: TextStyle(fontSize: 16.0),
                        ),
                        onPressed: _trySubmit,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
