import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todoey_flutter/models/task_model.dart';
import 'package:todoey_flutter/screens/add_task_screen.dart';
import 'package:todoey_flutter/widgets/task_calendar.dart';
import 'package:todoey_flutter/widgets/task_list.dart';

import '../main.dart';

class TaskScreen extends StatefulWidget {
  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 30.0,
              left: 30.0,
              right: 30.0,
              bottom: 10.0,
            ),
            child: Consumer<TaskModel>(
              builder: (context, task, child) {
                return TaskCalendar(
                  task.getSelectedDay,
                  task.getFocusDay,
                  task.setSelectedDay,
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Todoey',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Consumer<TaskModel>(
                builder: (context, task, child) {
                  return Text(
                    '(${task.getCount} tasks)',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 10.0,),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: TaskList(),
            ),
          ),
        ],
      ),
      floatingActionButton: Consumer<TaskModel>(
        builder: (context, task, child) {
          return Visibility(
            visible: task.getSelectedDay!.isAfter(DateTime.now()) ||
                isSameDay(DateTime.now(), task.getSelectedDay),
            child: FloatingActionButton(
              backgroundColor: Colors.lightBlueAccent,
              child: const Icon(
                Icons.add,
              ),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: AddTaskScreen(),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}