import 'package:Taskbud/Utils/global.dart';
import 'package:Taskbud/icons/task_bud_icon_icons.dart';
import 'package:Taskbud/models/task_model.dart';
import 'package:Taskbud/pages/dashBoardpage/update_taskModal.dart';
import 'package:Taskbud/providers/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskItem extends StatefulWidget {
  final Tasks tasks;
  final int index;

  const TaskItem({
    this.tasks,
    this.index,
  });

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  Future<void> updateTask() async {
    try {
      await Provider.of<TaskProvider>(context, listen: false).updateTask(
        widget.tasks.taskName,
        widget.tasks.description,
        widget.tasks.completed,
        widget.tasks.startTime,
        widget.tasks.endTime,
        widget.tasks.taskId,
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

  void _showModalBottom(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (context) {
        return UpdateTask(widget.tasks);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showModalBottom(context);
      },
      child: Container(
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
                  widget.tasks.taskName ?? "",
                  style: headerStyle,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(
                        widget.tasks.completed
                            ? TaskBudIcon.complete
                            : TaskBudIcon.hourglass_2,
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
            widget.tasks.description != null
                ? Text(widget.tasks.description)
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
                Text(widget.tasks.startTime),
              ],
            ),
            Row(
              children: [
                Icon(Icons.ac_unit),
                SizedBox(
                  width: 10.0,
                ),
                Text((widget.tasks.endTime)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
