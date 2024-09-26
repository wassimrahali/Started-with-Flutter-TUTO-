import 'package:first_app/model/Task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:first_app/libary/globals.dart' as globals;
import 'package:first_app/provider/TaskProvider.dart';

class AddTaskView extends StatefulWidget {
  const AddTaskView({super.key});

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskModel>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Add new Task",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Theme.of(context).primaryColor,
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TableCalendar(
                    calendarFormat: CalendarFormat.week,
                    firstDay: DateTime.utc(2010, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay: _focusedDay,
                    selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                    },
                    calendarBuilders: CalendarBuilders(
                      markerBuilder: (context, dateTime, events) {
                        int taskCount = model.countTasksByDate(dateTime);
                        return taskCount > 0
                            ? Container(
                          width: 20,
                          height: 15,
                          decoration: BoxDecoration(
                            color: globals.primaries[taskCount],
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Center(
                            child: Text(
                              taskCount.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                            : Container();
                      },
                      selectedBuilder: (context, dateTime, focusedDay) {
                        return Container(
                          decoration: BoxDecoration(
                            color: globals.primaries[5],
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
                          child: Center(
                            child: Text(
                              dateTime.day.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: TextFormField(
                      controller: titleController,
                      maxLength: 100,
                      decoration: InputDecoration(
                        hintText: "Enter Task Title",
                        focusedBorder: _outlineInputBorder(),
                        enabledBorder: _outlineInputBorder(),
                        errorBorder: _outlineInputBorder(color: Colors.red),
                        focusedErrorBorder: _outlineInputBorder(color: Colors.purple),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: TextFormField(
                      controller: descriptionController,
                      maxLength: 500,
                      maxLines: 7,
                      minLines: 5,
                      decoration: InputDecoration(
                        hintText: "Enter a Description (optional)",
                        focusedBorder: _outlineInputBorder(),
                        enabledBorder: _outlineInputBorder(),
                        errorBorder: _outlineInputBorder(color: Colors.red),
                        focusedErrorBorder: _outlineInputBorder(color: Colors.purple),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Task newTask = Task(titleController.text, false, descriptionController.text, _focusedDay);
                model.addTasks(newTask);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Task Saved ...')),
                );
                Navigator.pushReplacementNamed(context, 'listTasks');
              }
            },
            child: const Icon(Icons.done, color: Colors.white),
            backgroundColor: Theme.of(context).primaryColor,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  OutlineInputBorder _outlineInputBorder({Color color = Colors.blue}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: BorderSide(color: color, width: 2.0),
    );
  }
}
