import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/widgets/task_list.dart';
import 'package:todoey_flutter/screens/AddTaskScreen.dart';
import 'package:todoey_flutter/classes/task_data.dart';
import 'package:loading_overlay/loading_overlay.dart';

//TaskData().loadData();

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  Future<void> _neverSatisfied() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(20)),
          title: Text(
            'Instructions:',
            style: TextStyle(color: Colors.lightBlueAccent),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    '• Todoey is a to do list app that helps you managing your tasks.'),
                SizedBox(
                  height: 10,
                ),
                Text('• You can add your tasks using the + button.'),
                SizedBox(
                  height: 10,
                ),
                Text('• You can mark done tasks by pressing on them.'),
                SizedBox(
                  height: 10,
                ),
                Text(
                    '• You can delete a task by pressing on it for 2 seconds.'),
                SizedBox(
                  height: 10,
                ),
                Text(
                    '• Tasks added before will be loaded upon opening the app again.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void loadPrevData() async {
    await TaskData().loadData();
    Provider.of<TaskData>(context).update();

    bool a = await Provider.of<TaskData>(context).getOpenedBefore();
    //  print('MY ANSWER IS ${a}');
    if (!a) {
      _neverSatisfied();
      Provider.of<TaskData>(context).setOpenedBefore();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadPrevData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => AddTaskScreen(),
          );
        },
        backgroundColor: Colors.lightBlueAccent,
        child: Icon(
          Icons.add,
          size: 40,
        ),
        // isLoading: Provider.of<TaskData>(context).getSavingState(),
      ),
      body: LoadingOverlay(
        isLoading: Provider.of<TaskData>(context).getSavingState(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding:
                  EdgeInsets.only(top: 60, left: 30, right: 30, bottom: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      CircleAvatar(
                        child: Icon(
                          Icons.list,
                          size: 30,
                          color: Colors.lightBlueAccent,
                        ),
                        backgroundColor: Colors.white,
                        radius: 30,
                      ),
                      FlatButton(
                          // color: Colors.white,
                          onPressed: () {
                            // firstTimeDialog();
                            _neverSatisfied();
                          },
                          child: Icon(
                            Icons.info,
                            color: Colors.white,
                            size: 50,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Todoey',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.w700),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        Provider.of<TaskData>(context, listen: true)
                            .getNumberTasks()
                            .toString(),
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      // FlatButton(
                      //   onPressed: () async {
                      //     await TaskData().loadData();
                      //     Provider.of<TaskData>(context).update();
                      //   },
                      //   child: Text(
                      //     'Load data',
                      //     style: TextStyle(
                      //       fontSize: 17,
                      //       color: Colors.lightBlueAccent,
                      //       fontWeight: FontWeight.w700,
                      //     ),
                      //   ),
                      //   color: Colors.white,
                      // )
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: TaskList(
                    // tasks: myTasks,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
