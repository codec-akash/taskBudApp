import 'package:Taskbud/pages/dashBoardpage/TaskItem.dart';
import 'package:Taskbud/providers/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taskData = Provider.of<TaskProvider>(context);
    final tasks = taskData.tasks;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView.builder(
        itemCount: tasks.length,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (ctx, index) => TaskItem(
          tasks: tasks[index],
          index: index,
          show: true, //For incomplete
        ),
      ),
    );
  }
}
