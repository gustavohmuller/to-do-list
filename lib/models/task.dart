import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.expirationDate,
    required this.isDone,
  });

  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String description;

  @HiveField(3)
  DateTime expirationDate;

  @HiveField(4)
  bool isDone;

  createTask({required String title, required String description, required DateTime expirationDate}) {
    Task(
      id: const Uuid().v1(),
      title: title,
      description: description,
      expirationDate: expirationDate,
      isDone: false,
    );
  }
}
