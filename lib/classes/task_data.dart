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
    // Task(TaskContent: 'Go buy a batao owoaa', isdone: false),
    // Task(TaskContent: 'Go buy 2 eggs'),
    // Task(TaskContent: 'Go buy a third egg'),
    // Task(TaskContent: 'Go buy a batao owoaa'),
    // Task(TaskContent: 'Go buy 2 eggs'),
    // Task(TaskContent: 'Go buy 5 eggs'),
  ];

  void addTask(String task) {
    if (task != "") {
      _tasksdata.add(Task(TaskContent: task, isdone: false));
      notifyListeners();
      saveData();
    }
  }

  void saveData() async {
    changeSavingState();
    notifyListeners();
    _prefs = await SharedPreferences.getInstance();
    _prefs.clear();
    _prefs.setInt('number', _tasksdata.length);

    for (int i = 0; i < _tasksdata.length; i++) {
      _prefs.setBool('boolean $i', _tasksdata[i].isdone);
      _prefs.setString('task $i', _tasksdata[i].TaskContent);
    }
    //  print(_prefs.getInt('number'));
    changeSavingState();
    notifyListeners();
  }

  void loadData() async {
    notifyListeners();
    changeSavingState();
    notifyListeners();
    _prefs = await SharedPreferences.getInstance();

    int a = _prefs.getInt('number');
    print(a);
    for (int i = 0; i < a; i++) {
      // print('task is ${_prefs.getString('task $i')}');
      // print('bool is ${_prefs.getBool('boolean $i')}');
      _tasksdata.add(Task(
          TaskContent: _prefs.getString('task $i'),
          isdone: _prefs.getBool('boolean $i')));

      notifyListeners();
    }
    // notifyListeners();
    print('number is ${getNumberTasks()}');
    for (var a in _tasksdata) {
      print('task is ${a.TaskContent}');
      print('bool is ${a.isdone}');
    }
    // print('number in ${_tasksdata.length}');
    changeSavingState();
    notifyListeners();
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
