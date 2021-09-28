import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/models/task.dart';
import 'package:todoey_flutter/models/task_model.dart';

class AddTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String taskTitle = '';
    return Container(
      color: const Color(0xff757575),
      child: Container(
        padding: const EdgeInsets.all(30.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Add Task',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.lightBlueAccent,
                  fontSize: 30.0,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextField(
                autofocus: true,
                decoration: const InputDecoration(
                  fillColor: Colors.lightBlueAccent,
                ),
                onChanged: (newValue) {
                  taskTitle = newValue;
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
              Consumer<TaskModel>(builder: (context, task, child) {
                return TextButton(
                    onPressed: () {
                      task.addTask(
                        Task(name: taskTitle, day: task.getSelectedDay),
                      );
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'ADD',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.lightBlueAccent,
                    ));
              }),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
