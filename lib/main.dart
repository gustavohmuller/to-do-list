import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';

import 'package:to_do_list/database/hive_database.dart';
import 'package:to_do_list/models/task.dart';
import 'package:to_do_list/utils/strings.dart';
import 'package:to_do_list/views/home_view.dart';

Future<void> main() async {
  await Hive.initFlutter();

  Hive.registerAdapter<Task>(TaskAdapter());

  await Hive.openBox<Task>('tasksBox');

  runApp(BaseWidget(child: const ToDoListApp()));
}

class BaseWidget extends InheritedWidget {
  BaseWidget({Key? key, required this.child}) : super(key: key, child: child);
  @override
  // ignore: overridden_fields
  final Widget child;
  final HiveDatabase dataStore = HiveDatabase();

  static BaseWidget of(BuildContext context) {
    final base = context.dependOnInheritedWidgetOfExactType<BaseWidget>();
    if (base != null) {
      return base;
    } else {
      throw StateError;
    }
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}

class ToDoListApp extends StatelessWidget {
  const ToDoListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: materialAppTitle,
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
