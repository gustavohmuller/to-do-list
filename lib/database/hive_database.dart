import 'package:flutter/foundation.dart';

import 'package:hive_flutter/adapters.dart';

import '../models/task.dart';

class HiveDatabase {
  Box<Task> tasksBox = Hive.box<Task>('tasksBox');

  Task? getTask({required String title}) {
    return tasksBox.get(title);
  }

  bool addTask({required Task task}) {
    if (tasksBox.containsKey(task.title)) {
      return false;
    }

    tasksBox.put(task.title, task);

    return true;
  }

  void deleteTask({required Task task}) {
    task.delete();
  }

  void updateTask({required Task task}) {
    task.save();
  }

  ValueListenable<Box<Task>> listenToTask() {
    return tasksBox.listenable();
  }
}
