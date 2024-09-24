import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:first_app/libary/globals.dart' as globals;

import '../provider/TaskProvider.dart';

class ListTaskWidget extends StatefulWidget {
  const ListTaskWidget({super.key});

  @override
  State<ListTaskWidget> createState() => _ListTaskWidgetState();
}

class _ListTaskWidgetState extends State<ListTaskWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskModel>(builder: (context, model, child) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: model.todoTasks[globals.today]!.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.purple,
                    border: Border.all(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(model.todoTasks[globals.today]![index].title),
                  subtitle: Text(
                      model.todoTasks[globals.today]![index].deadline.toString()),
                  leading: Checkbox(
                    value: model.todoTasks[globals.today]![index].status,
                    onChanged: (bool? value) {
                      model.markAsDone(globals.today, index);
                      print(model.todoTasks[globals.today]![index].status);
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
