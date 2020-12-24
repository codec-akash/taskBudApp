import 'package:Taskbud/Utils/global.dart';
import 'package:Taskbud/icons/task_bud_icon_icons.dart';
import 'package:Taskbud/providers/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskItem extends StatefulWidget {
  final String taskId;
  final String taskName;
  final String taskDescription;
  final bool isComplete;
  final String startTime;
  final String endTime;

  const TaskItem({
    this.taskId,
    this.taskName,
    this.taskDescription,
    this.isComplete,
    this.startTime,
    this.endTime,
  });

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  Future<void> updateTask() async {
    try {
      await Provider.of<TaskProvider>(context, listen: false).updateTask(
        widget.taskName,
        widget.taskDescription,
        widget.isComplete,
        widget.startTime,
        widget.endTime,
        widget.taskId,
      );
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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      decoration: BoxDecoration(
          gradient: Global(context).cardBackgroundGradient(),
          borderRadius: BorderRadius.circular(18.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.taskName,
                style: headerStyle,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(
                      widget.isComplete
                          ? TaskBudIcon.complete
                          : TaskBudIcon.crossed_bones,
                    ),
                    onPressed: updateTask,
                  ),
                  IconButton(
                      icon: Icon(
                        TaskBudIcon.delete,
                      ),
                      onPressed: () {}),
                ],
              ),
            ],
          ),
          widget.taskDescription != null
              ? Text(widget.taskDescription)
              : Container(),
          SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              Icon(Icons.ac_unit),
              SizedBox(
                width: 10.0,
              ),
              Text(widget.startTime),
            ],
          ),
          Row(
            children: [
              Icon(Icons.ac_unit),
              SizedBox(
                width: 10.0,
              ),
              Text(widget.endTime),
            ],
          ),
        ],
      ),
    );
  }
}
