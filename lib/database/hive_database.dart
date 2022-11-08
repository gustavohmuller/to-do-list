import 'package:hive/hive.dart';

class HiveDatabase {
  var tasksBox = Hive.box('tasks');

  getTask({required task}) {
    return tasksBox.get(task.id);
  }

  addTask({required task}) async {
    await tasksBox.put(task.id, task);
  }

  deleteTask({required task}) async {
    await task.delete();
  }

  updateTask({required task}) async {
    await task.save();
  }
}
