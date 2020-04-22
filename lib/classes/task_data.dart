import 'dart:collection';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'Task.dart';

class TaskData extends ChangeNotifier {
  SharedPreferences _prefs;

  bool _savingloadingbool = false;

  bool getSavingState() => _savingloadingbool;

  void changeSavingState() {
    _savingloadingbool = !_savingloadingbool;
    notifyListeners();
  }

  List<Task> _tasksdata = [
    // Task(TaskContent: 'Go buy a batao owoaa'),
    // Task(TaskContent: 'Go buy 2 eggs'),
    // Task(TaskContent: 'Go buy a third egg'),
    // Task(TaskContent: 'Go buy a batao owoaa'),
    // Task(TaskContent: 'Go buy 2 eggs'),
    // Task(TaskContent: 'Go buy 5 eggs'),
  ];

  void addTask(String task) {
    _tasksdata.add(Task(TaskContent: task));
    notifyListeners();
    // saveData();
  }

  void saveData() async {
    changeSavingState();
    _prefs = await SharedPreferences.getInstance();
    _prefs.setInt('number', _tasksdata.length);

    for (int i = 0; i < _tasksdata.length; i++) {
      _prefs.setBool('boolean $i', _tasksdata[i].isdone);
      _prefs.setString('task $i', _tasksdata[i].TaskContent);
    }
    changeSavingState();
  }

  void loadData() async {
    changeSavingState();
    _prefs = await SharedPreferences.getInstance();

    int a = _prefs.getInt('number');
    print(a);
    // bool b;
    // String c;
    // for (int i = 0; i < a; i++) {
    //   _tasksdata.add(Task(
    //       TaskContent: _prefs.getString('task $i'),
    //       isdone: _prefs.getBool('boolean $i')));
    // }

    changeSavingState();
  }

  int getNumberTasks() => _tasksdata.length;

  // List<Task> getTasks() => tasksdata;
  UnmodifiableListView<Task> getTasks() {
    return UnmodifiableListView(_tasksdata);
  }

  void deleteTask(Task task) {
    _tasksdata.remove(task);
    notifyListeners();
    saveData();
  }

  void toggleDone(Task task) {
    task.ToggleDone();
    notifyListeners();
    saveData();
  }
}
