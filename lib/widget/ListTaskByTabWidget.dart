import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:first_app/libary/globals.dart' as globals;

import '../provider/TaskProvider.dart';

class ListTaskByTabWidget extends StatefulWidget {
  final String tabKey;
  const ListTaskByTabWidget({Key? key, required this.tabKey}) : super(key: key);

  @override
  State<ListTaskByTabWidget> createState() => _ListTaskWidgetState();
}

class _ListTaskWidgetState extends State<ListTaskByTabWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskModel>(builder: (context, model, child) {
      final tasks = model.todoTasks[widget.tabKey];
      // Check if tasks exist and are not null
      if (tasks == null || tasks.isEmpty) {
        return Center(child: Text('No tasks available'));
      }

      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (BuildContext context, int index) {
            final task = tasks[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.purple,
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Text(task.title),
                  subtitle: Text(task.deadline.toString()),
                  leading: Checkbox(
                    value: task.status,
                    onChanged: (bool? value) {
                      model.markAsDone(widget.tabKey, index);
                      print(task.status);
                    },
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
