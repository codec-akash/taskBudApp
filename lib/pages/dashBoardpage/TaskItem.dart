import 'package:Taskbud/Utils/global.dart';
import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  final String taskName;
  final String taskDescription;
  final bool isComplete;
  final String startTime;
  final String endTime;

  const TaskItem({
    this.taskName,
    this.taskDescription,
    this.isComplete,
    this.startTime,
    this.endTime,
  });

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
                taskName,
                style: headerStyle,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(icon: Icon(Icons.cake), onPressed: () {}),
                  IconButton(icon: Icon(Icons.cake), onPressed: () {}),
                ],
              ),
            ],
          ),
          Text(taskDescription),
          SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              Icon(Icons.ac_unit),
              SizedBox(
                width: 10.0,
              ),
              Text(startTime),
            ],
          ),
          Row(
            children: [
              Icon(Icons.ac_unit),
              SizedBox(
                width: 10.0,
              ),
              Text(endTime),
            ],
          ),
        ],
      ),
    );
  }
}
