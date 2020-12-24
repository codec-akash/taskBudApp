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
        itemBuilder: (ctx, index) => TaskItem(
          taskId: tasks[index].taskId,
          taskName: tasks[index].taskName,
          taskDescription: tasks[index].description,
          startTime: tasks[index].startTime,
          endTime: tasks[index].endTime,
          isComplete: tasks[index].completed,
        ),
      ),
    );
  }
}
