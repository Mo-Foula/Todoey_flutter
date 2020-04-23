import 'dart:collection';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'Task.dart';

class TaskData extends ChangeNotifier {
  SharedPreferences _prefs;

  static bool _savingloadingbool = false;

  bool getSavingState() => _savingloadingbool;

  void changeSavingState() {
    _savingloadingbool = !_savingloadingbool;
    notifyListeners();
  }

  void update() {
    notifyListeners();
  }

  static List<Task> _tasksdata = [
    // Task(TaskContent: 'Go buy a batao owoaa', isdone: false),
    // Task(TaskContent: 'Go buy 2 eggs'),
    // Task(TaskContent: 'Go buy a third egg'),
    // Task(TaskContent: 'Go buy a batao owoaa'),
    // Task(TaskContent: 'Go buy 2 eggs'),
    // Task(TaskContent: 'Go buy 5 eggs'),
  ];

  void addTask(String task, bool done) {
    if (task != "") {
      _tasksdata.add(Task(taskContent: task, isdone: done));
      notifyListeners();
      saveData();
    }
  }

  bool getOpenedBefore() =>
      _prefs.getBool('opened_before') != null ? true : false;

  void saveData() async {
    changeSavingState();
    notifyListeners();
    _prefs = await SharedPreferences.getInstance();
    _prefs.clear();
    _prefs.setInt('number', _tasksdata.length);
    _prefs.setBool('opened_before', true);
    for (int i = 0; i < _tasksdata.length; i++) {
      _prefs.setBool('boolean $i', _tasksdata[i].isdone);
      _prefs.setString('task $i', _tasksdata[i].taskContent);
    }
    //  print(_prefs.getInt('number'));
    changeSavingState();
    notifyListeners();
  }

  void loadData2222() async {
    List<Task> dADA = [];

    changeSavingState();
    notifyListeners();

    _prefs = await SharedPreferences.getInstance();

    int a = _prefs.getInt('number');
    print(a);
    for (int i = 0; i < a; i++) {
      // print('task is ${_prefs.getString('task $i')}');
      // print('bool is ${_prefs.getBool('boolean $i')}');
      dADA.add(Task(
          taskContent: _prefs.getString('task $i'),
          isdone: _prefs.getBool('boolean $i')));
    }
    // notifyListeners();
    print('number is ${getNumberTasks()}');
    _tasksdata = dADA;
    for (var a in _tasksdata) {
      print('task is ${a.taskContent}');
      print('bool is ${a.isdone}');
    }
    // print('number in ${_tasksdata.length}');
    changeSavingState();
    notifyListeners();
    print('number of tasks ${getNumberTasks()}');
  }

  void loadData() async {
    _tasksdata.clear();
    changeSavingState();
    notifyListeners();

    _prefs = await SharedPreferences.getInstance();

    int a = _prefs.getInt('number');
    if (a == null) {
      changeSavingState();
      notifyListeners();
      return;
    }
    // print(a);
    for (int i = 0; i < a; i++) {
      // print('\nINSIDE LOOP ');
      // print('task is ${_prefs.getString('task $i')}');
      // print('bool is ${_prefs.getBool('boolean $i')}\n\n');

      addTask(_prefs.getString('task $i'), _prefs.getBool('boolean $i'));
    }
    // notifyListeners();
    // print('number is ${getNumberTasks()}\n\n');
    // for (var a in _tasksdata) {
    //   print('task is ${a.taskContent}');
    //   print('bool is ${a.isdone}\n\n');
    // }
    changeSavingState();
    notifyListeners();
    // print('number in ${_tasksdata.length}');
    // update();
    // print('number of tasks ${getNumberTasks()} at end');
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
    task.toggleDone();
    notifyListeners();
    saveData();
  }
}
