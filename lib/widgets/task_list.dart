import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'task_tile.dart';
import 'package:todoey_flutter/classes/task_data.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskdatainstance, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            return TaskListTile(
              // task: taskdatainstance.getTasks()[index].TaskContent,
              task:
                  Provider.of<TaskData>(context).getTasks()[index].TaskContent,
              myval: Provider.of<TaskData>(context).getTasks()[index].isdone,
              onChangedFunction: () {
                taskdatainstance.toggleDone(taskdatainstance.getTasks()[index]);
              },
              deleteTaskFun: () {
                taskdatainstance.deleteTask(taskdatainstance.getTasks()[index]);
              },
            );
          },
          itemCount: taskdatainstance.getTasks().length,
        );
      },
    );
  }
}
