import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  Task({
    required this.title,
    required this.description,
    required this.expirationDate,
    required this.isDone,
  });

  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  @HiveField(2)
  DateTime expirationDate;

  @HiveField(3)
  bool isDone;

  factory Task.createTask({
    required String title,
    required String description,
    DateTime? expirationDate,
  }) =>
      Task(
        title: title,
        description: description,
        expirationDate: expirationDate ?? DateTime.now(),
        isDone: false,
      );
}
