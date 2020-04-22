import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/classes/task_data.dart';

class AddTaskScreen extends StatelessWidget {
  String myTask = "";
  void onAddFunction(String tsk) {}

  TextEditingController texteditingcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[600],
      child: Container(
        padding: EdgeInsets.only(top: 30, left: 60, right: 60),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "Add Task",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                color: Colors.lightBlueAccent,
              ),
            ),
            TextField(
              controller: texteditingcontroller,
              style: TextStyle(fontSize: 20),
              autofocus: true,
              textAlign: TextAlign.center,
              onChanged: (v) {
                myTask = v;
              },
            ),
            SizedBox(
              height: 20,
            ),
            FlatButton(
              child: Padding(
                child: Text(
                  "Add",
                  style: TextStyle(color: Colors.white),
                ),
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              color: Colors.lightBlueAccent,
              onPressed: () {
                if (myTask != "")
                  Provider.of<TaskData>(context).addTask(myTask);
                texteditingcontroller.clear();
              },
            ),
          ],
        ),
      ),
    );
  }
}
