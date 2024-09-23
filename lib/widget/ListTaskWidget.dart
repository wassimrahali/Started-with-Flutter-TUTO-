import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/TaskProvider.dart';

class ListTaskWidget extends StatefulWidget {
  const ListTaskWidget({super.key});

  @override
  State<ListTaskWidget> createState() => _ListTaskWidgetState();
}

class _ListTaskWidgetState extends State<ListTaskWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskModel>(
        builder: (context, model, child) {
          return ListView.builder(
            itemCount: model.todoTasks.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.lightGreen,
                      border: Border.all(
                        color: Colors.black,

                      ),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: CheckboxListTile(
                    title: Text(model.todoTasks[index].title),
                    value: model.todoTasks[index].status,
                    subtitle: Text(model.todoTasks[index].deadline.toString()),
                    onChanged: (bool? value) {
                      model.markAsDone(index, value!);
                      print(model.todoTasks[index].status);
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ),
              );
            },
          );
        }
    );
  }
}
