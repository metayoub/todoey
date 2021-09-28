import 'package:flutter/material.dart';

class TaskListTile extends StatelessWidget {
  final bool isChecked;
  final String taskTitle;
  final Function toggleChecked;

  TaskListTile({
    required this.taskTitle,
    required this.isChecked,
    required this.toggleChecked,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        taskTitle,
        style: TextStyle(
          decoration: isChecked ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: Checkbox(
        value: isChecked,
        activeColor: Colors.lightBlueAccent,
        onChanged: toggleChecked as void Function(bool?)?,
      ),
    );
  }
}
