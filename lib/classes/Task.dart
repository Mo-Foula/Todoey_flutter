import 'package:flutter/cupertino.dart';

class Task {
  final String TaskContent;

  bool isdone = false;
  Task({@required this.TaskContent, this.isdone});

  void ToggleDone() {
    isdone = !isdone;
  }
}
