import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/TaskScreen.dart';
import 'classes/task_data.dart';
import 'classes/Task.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TaskData>(
      create: (context) => TaskData(),
      child: MaterialApp(
        home: TaskScreen(),
      ),
    );
  }
}
