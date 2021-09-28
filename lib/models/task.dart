import 'package:hive/hive.dart';
part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject{

  @HiveField(0)
  final String name;

  @HiveField(1)
  bool isDone;

  @HiveField(2)
  var day;

  Task({required this.name, this.day, this.isDone = false});

  void toggleDone() {
    isDone = !isDone;
  }
}