import 'package:first_app/model/Task.dart';
import 'package:flutter/cupertino.dart';
import 'package:first_app/libary/globals.dart' as globals;
import 'package:dart_date/dart_date.dart';

class TaskModel extends ChangeNotifier {
  final Map<String, List<Task>> _todoTasks = {
    globals.late: [
      Task("Task 1", false, "Create Provider", DateTime.now().add(Duration(days: 1)))
    ],
    globals.today: [
      Task("Today Task 1", false, "Create Provider", DateTime.now().add(Duration(days: 1)))
    ],
    globals.tomorrow: [
      Task("Tomorrow Task 1", false, "Create Provider", DateTime.now().add(Duration(days: 1)))
    ],
    globals.thisWeek: [
      Task("thisWeek Task 1", false, "Create Provider", DateTime.now().add(Duration(days: 1)))
    ],
    globals.nextWeek: [
      Task("nextWeek Task 1", false, "Create Provider", DateTime.now().add(Duration(days: 1)))
    ],
    globals.thisMonth: [
      Task("ThisMonth Task 1", false, "Create Provider", DateTime.now().add(Duration(days: 1)))
    ],
    globals.later: [
      Task("Later Task 1", false, "Create Provider", DateTime.now().add(Duration(days: 1)))
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

  void addTasks(Task _task) {
    String _key = guessTodoKeyFromDate(_task.deadline);
    if (_todoTasks.containsKey(_key)) {
      _todoTasks[_key]!.add(_task);
      notifyListeners();
    }
  }

  void markAsDone(String key, int index) {
    if (_todoTasks.containsKey(key) && index < _todoTasks[key]!.length) {
      _todoTasks[key]![index].status = true;
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
    } else if (deadline.getWeek == DateTime.now().getWeek) {
      return globals.thisWeek;
    } else if (deadline.getWeek == DateTime.now().getWeek + 1) {
      return globals.nextWeek;
    } else if (deadline.isThisMonth) {
      return globals.thisMonth;
    } else {
      return globals.later;
    }
  }
}
