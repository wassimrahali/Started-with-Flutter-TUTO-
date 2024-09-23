import 'package:first_app/model/Task.dart';
import 'package:flutter/cupertino.dart';

class TaskModel extends ChangeNotifier {

  final List<Task> _toDoTasks = [
    Task("Task 1",true,"Create Provider",DateTime.now().add(Duration(days: 1))),
    Task("Task 2",false,"Create Provider",DateTime.now().subtract(Duration(days: 1))),
    Task("Task 3",false,"Create Provider",DateTime.now().add(Duration(days: 7))),
    Task("Task 4",false,"Create Provider",DateTime.now().add(Duration(days: 2))),
  ];

  List<Task> get todoTasks => _toDoTasks;
  void addTasks(Task _task){
    _toDoTasks.add(_task);
    notifyListeners();
  }

  void markAsDone(int index,bool _status){
    _toDoTasks[index].status = _status ;
    notifyListeners();
  }


}