import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/models/task_model.dart';
import 'package:todoey_flutter/widgets/task_list_tile.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskModel>(
      builder: (context, task, child) {
        return ListView.builder(
          itemCount: task.getCount,
          itemBuilder: (context, index) {
            final item = task.getList[index];
            return Dismissible(
              key: Key(item.name),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                task.deleteTask(item);
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${item.name} dismissed')));
              },
              confirmDismiss: (DismissDirection direction) async {
                return await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Delete Confirmation"),
                      content: const Text("Are you sure you want to delete this task?"),
                      actions: <Widget>[
                        TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text("Delete")
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text("Cancel"),
                        ),
                      ],
                    );
                  },
                );
              },
              // Show a red background as the item is swiped away.
              background: Container(
                color: Colors.red,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Icon(
                        Icons.delete_forever,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10.0,),
                      Text(
                        'Delete',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              child: TaskListTile(
                taskTitle: task.getList[index].name,
                isChecked: task.getList[index].isDone,
                toggleChecked: (bool? checkBoxState) {
                  task.toggleDone(task.getList[index]);
                },
              ),
            );
          },
        );
      },
    );
  }
}
