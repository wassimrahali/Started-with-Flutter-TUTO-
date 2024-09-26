import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:first_app/model/Task.dart';
import 'package:flutter/cupertino.dart';
import 'package:first_app/libary/globals.dart' as globals;
import 'package:dart_date/dart_date.dart';

class TaskModel extends ChangeNotifier {
  final Map<String, List<Task>> _todoTasks = {
    globals.late: [
      Task("Overdue Task 1", true, "Finish project report", DateTime.now().subtract(Duration(days: 1))),
      Task("Overdue Task 2", true, "Submit assignment", DateTime.now().subtract(Duration(days: 2))),
    ],
    globals.today: [
      Task("Today's Task 1", false, "Attend team meeting", DateTime.now()),
      Task("Today's Task 2", false, "Grocery shopping", DateTime.now()),
    ],
    globals.tomorrow: [
      Task("Tomorrow's Task 1", false, "Doctor's appointment", DateTime.now().add(Duration(days: 1))),
      Task("Tomorrow's Task 2", false, "Call Mom", DateTime.now().add(Duration(days: 1))),
    ],
    globals.thisWeek: [
      Task("This Week Task 1", false, "Finish the Flutter project", DateTime.now().add(Duration(days: 3))),
      Task("This Week Task 2", false, "Read a new book", DateTime.now().add(Duration(days: 5))),
    ],
    globals.nextWeek: [
      Task("Next Week Task 1", false, "Plan vacation", DateTime.now().add(Duration(days: 7))),
      Task("Next Week Task 2", false, "Prepare for presentation", DateTime.now().add(Duration(days: 9))),
    ],
    globals.thisMonth: [
      Task("This Month Task 1", false, "Complete the course", DateTime.now().add(Duration(days: 15))),
      Task("This Month Task 2", false, "Start new exercise routine", DateTime.now().add(Duration(days: 20))),
    ],
    globals.later: [
      Task("Later Task 1", false, "Learn a new language", DateTime.now().add(Duration(days: 30))),
      Task("Later Task 2", false, "Visit the museum", DateTime.now().add(Duration(days: 45))),
    ],
  };

  Map<String, List<Task>> get todoTasks => _todoTasks;
  int countTasksByDate(DateTime _datetime) {
    String _key = guessTodoKeyFromDate(_datetime);
    if (_todoTasks.containsKey(_key)) {
      return _todoTasks[_key]!.where((task) =>
      task.deadline.day == _datetime.day &&
          task.deadline.month == _datetime.month &&
          task.deadline.year == _datetime.year
      ).length;
    }
    return 0;
  }

  // Constructor to load tasks when the TaskModel is created
  TaskModel() {
    loadTasks();
  }

  // Save tasks to shared preferences
  Future<void> saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> jsonTasks = _todoTasks.map((key, value) => MapEntry(
      key,
      jsonEncode(value.map((task) => task.toJson()).toList()),
    ));
    prefs.setString('tasks', jsonEncode(jsonTasks));
  }

  // Load tasks from shared preferences
  Future<void> loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('tasks')) {
      String? tasksString = prefs.getString('tasks');
      if (tasksString != null) {
        Map<String, dynamic> jsonTasks = jsonDecode(tasksString);
        jsonTasks.forEach((key, value) {
          _todoTasks[key] = (jsonDecode(value) as List)
              .map((taskJson) => Task.fromJson(taskJson))
              .toList();
        });
      }
      notifyListeners();
    }
  }

  // Adding task and caching it
  void addTasks(Task _task) {
    String _key = guessTodoKeyFromDate(_task.deadline);
    if (_todoTasks.containsKey(_key)) {
      _todoTasks[_key]!.add(_task);
      saveTasks(); // Cache the updated task list
      notifyListeners();
    }
  }

  void markAsDone(String key, int index) {
    if (_todoTasks.containsKey(key) && index < _todoTasks[key]!.length) {
      _todoTasks[key]![index].status = true;
      saveTasks(); // Cache the updated task status
      notifyListeners();
    }
  }

  String guessTodoKeyFromDate(DateTime deadline) {
    if (deadline.isPast && !deadline.isToday) {
      return globals.late;
    } else if (deadline.isToday) {
      return globals.today;
    } else if (deadline.isTomorrow) {
      return globals.tomorrow;
    } else if (deadline.getWeek == DateTime.now().getWeek &&
        deadline.year == DateTime.now().year) {
      return globals.thisWeek;
    } else if (deadline.getWeek == DateTime.now().getWeek + 1 &&
        deadline.year == DateTime.now().year) {
      return globals.nextWeek;
    } else if (deadline.isThisMonth) {
      return globals.thisMonth;
    } else {
      return globals.later;
    }
  }
}
