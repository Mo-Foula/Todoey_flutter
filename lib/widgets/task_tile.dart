import 'package:flutter/material.dart';

class TaskListTile extends StatelessWidget {
  final String task;
  final bool myval;
  final Function onChangedFunction;
  final Function deleteTaskFun;

  TaskListTile({
    @required this.task,
    @required this.myval,
    @required this.onChangedFunction,
    @required this.deleteTaskFun,
  });

  // void onChangedFunction(BuildContext b) {
  //   Provider.of<TaskData>(b).toggleDone(task);
  // }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onLongPress: deleteTaskFun,
      onPressed: onChangedFunction,
      child: ListTile(
        title: Text(
          task,
          style:
              TextStyle(decoration: myval ? TextDecoration.lineThrough : null),
        ),
        trailing: Checkbox(
          activeColor: Colors.lightBlueAccent,
          value: myval,
          onChanged: (a) {
            onChangedFunction();
          },
        ),
      ),
    );
  }
}

// class TaskListTile extends StatefulWidget {
//   @override
//   _TaskListTile createState() => _TaskListTile();
// }

// class TaskListTile extends StatefulWidget {
//   String task;

//   TaskListTile({@required this.task});

//   @override
//   _TaskListTileState createState() => _TaskListTileState();
// }

// class _TaskListTileState extends State<TaskListTile> {
//   bool myval = false;

//   void OnValChange(bool val) {
//     setState(() {
//       myval = val;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FlatButton(
//       onPressed: () {
//         OnValChange(myval ? false : true);
//       },
//       child: ListTile(
//         title: Text(
//           widget.task,
//           style:
//               TextStyle(decoration: myval ? TextDecoration.lineThrough : null),
//         ),
//         trailing: Checkbox(
//           activeColor: Colors.lightBlueAccent,
//           value: val,
//           onChanged: toggleval,
//         ),
//       ),
//     );
//   }
// }

// MyCheckBox(val: myval, toggleval: OnValChange),
// class MyCheckBox extends StatelessWidget {
//   final bool val;
//   final Function toggleval;

//   MyCheckBox({@required this.val, @required this.toggleval});

//   @override
//   Widget build(BuildContext context) {
//     return Checkbox(
//       activeColor: Colors.lightBlueAccent,
//       value: val,
//       onChanged: toggleval,
//     );
//   }
// }
