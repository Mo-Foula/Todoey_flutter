import 'package:flutter/cupertino.dart';

class Task {
  final String taskContent;

  bool isdone = false;
  Task({@required this.taskContent, this.isdone});

  void toggleDone() {
    isdone = !isdone;
  }
}
