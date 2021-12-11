import 'package:flutter/material.dart';

class TaskTile extends StatefulWidget {
  // const TaskTile({Key? key}) : super(key: key);
  String itemText;
  int index;
  final Function() completed;

  TaskTile({
    Key? key,
    required this.itemText,
    required this.index,
    required this.completed,
  }) : super(key: key);

  @override
  _TaskTileState createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  bool? isChecked = false;
  bool done = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        '${widget.itemText}',
        style: TextStyle(
          decoration: (done) ? TextDecoration.lineThrough : TextDecoration.none,
          color: (done) ? Colors.red : Colors.black,
          fontWeight: (done) ? FontWeight.w500 : FontWeight.w500,
        ),
      ),
      trailing: TaskCheckBox(
        checkboxState: isChecked,
        update: (v) {
          print("TaskCheckBox, update(v), v is {$v}");
          on_tapped(toggle: false, checkboxValue: v);
        },
      ),
      onTap: on_tapped,
    );
  }

  void on_tapped({bool toggle = true, bool? checkboxValue = false}) {
    if (toggle) {
      setState(() {
        if (done == true) {
          done = false;
        } else {
          done = true;
        }
        isChecked = done;
      });
    } else {
      print("checkboxValue a {$checkboxValue!}");

      if (checkboxValue!) {
        setState(() {
          done = true;
          isChecked = true;
        });
      }

      if (checkboxValue == false) {
        setState(() {
          done = false;
          isChecked = false;
        });
      }
    }
    widget.completed();
  }
}

class TaskCheckBox extends StatefulWidget {
  bool? checkboxState;

  final Function(bool?) update;

  TaskCheckBox({required this.checkboxState, required this.update});

  @override
  State<TaskCheckBox> createState() => _TaskCheckBoxState();
}

class _TaskCheckBoxState extends State<TaskCheckBox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primarySwatch: Colors.blue,
        unselectedWidgetColor: Colors.black, // Your color
      ),
      child: Checkbox(
        value: widget.checkboxState,
        activeColor: Colors.tealAccent.shade700,
        onChanged: (bool? value) {
          widget.update(value);
        },
      ),
    );
  }
}
