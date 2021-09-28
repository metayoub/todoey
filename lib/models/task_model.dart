import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todoey_flutter/models/task.dart';

class TaskModel extends ChangeNotifier {
  List<Task> _tasks = [];
  DateTime? _selectedDay = DateTime.now();
  DateTime _focusDay = DateTime.now();

  final String _dbKey = 'task';
  late Box<dynamic> _db;

  TaskModel(Box<dynamic> db){
    _db=db;
    List<dynamic>  taskList = _db.containsKey(_dbKey)  ? _db.get(_dbKey) : [];
    makeTaskList(taskList);
  }

  void makeTaskList(taskList){
    for (var item in taskList) {
      _tasks.add(item);
    }
  }

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<Task> get getList => UnmodifiableListView(_tasks.where((element) => isSameDay(element.day, _selectedDay)));

  DateTime? get getSelectedDay => _selectedDay;

  DateTime get getFocusDay => _focusDay;

  void  setSelectedDay(DateTime? date, DateTime focusDate) {
    _selectedDay = date;
    _focusDay = focusDate;
    notifyListeners();
  }

  int get getCount => getList.length;

  void addTask(Task task) {
    _tasks.add(task);
    _db.put(_dbKey, _tasks);
    notifyListeners();
  }

  void toggleDone(Task task){
    _tasks.firstWhere((element) => element == task).toggleDone();
    // _tasks[index].toggleDone();
    _db.put(_dbKey, _tasks);
    notifyListeners();
  }
  
  void deleteTask(Task task) {
    _tasks.remove(task);
    _db.put(_dbKey, _tasks);
    notifyListeners();
  }

}