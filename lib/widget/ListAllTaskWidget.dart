import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:first_app/libary/globals.dart' as globals;

import '../provider/TaskProvider.dart';

class ListAllTaskWidget extends StatefulWidget {
  const ListAllTaskWidget({super.key});

  @override
  State<ListAllTaskWidget> createState() => _ListAllTaskWidgetState();
}

class _ListAllTaskWidgetState extends State<ListAllTaskWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskModel>(builder: (context, model, child) {
      return ListView.builder(
        itemCount: model.todoTasks.length,
        itemBuilder: (BuildContext context, int index) {
          String key = model.todoTasks.keys.elementAt(index);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  globals.taskCategoryNames[key]!,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(), // Prevent scrolling in the inner list
                itemCount: model.todoTasks[key]?.length ?? 0, // Dynamic count based on key
                itemBuilder: (BuildContext context, int innerIndex) {
                  final task = model.todoTasks[key]![innerIndex];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        border: Border.all(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: CheckboxListTile(
                        title: Text(task.title),
                        value: task.status,
                        subtitle: Text(task.deadline.toString()),
                        onChanged: (bool? value) {
                          model.markAsDone(key, innerIndex);
                          print(task.status);
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
      );
    });
  }
}
