import 'package:Taskbud/pages/dashBoardpage/TaskItem.dart';
import 'package:Taskbud/providers/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taskData = Provider.of<TaskProvider>(context);
    final tasks = taskData.tasks;
    final len = taskData.completedLength;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: len == 0
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("images/empty.png"),
                  Text("No Data"),
                ],
              ),
            )
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (ctx, index) => TaskItem(
                tasks: tasks[index],
                index: index,
                show: false, //For complete
              ),
            ),
    );
  }
}
