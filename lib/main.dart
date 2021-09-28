import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todoey_flutter/models/task_model.dart';
import 'package:todoey_flutter/screens/task_screen.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoey_flutter/services/notification_service.dart';

import 'models/task.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await notificationService.periodicNotification();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(TaskAdapter());
  final Box<dynamic> db = await Hive.openBox('appDB');

  runApp(
    MyApp(database: db),
  );
}

onNotificationLowerVersions(){

}

onNotificationClick(payload){
  print(payload);
}


class MyApp extends StatelessWidget {

  final Box<dynamic> database;

  MyApp({required this.database});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskModel(database),
      child: MaterialApp(
        home: TaskScreen(),
      ),
    );
  }

}
