import 'package:flutter/material.dart';
import 'package:to_do_list/components/task_card.dart';

import '../main.dart';
import '../models/task.dart';
import '../utils/strings.dart';
import '../utils/theme.dart';

class TasksList extends StatelessWidget {
  const TasksList({
    Key? key,
    required this.tasksList,
    required this.base,
  }) : super(key: key);

  final List<Task> tasksList;
  final BaseWidget base;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: tasksList.length,
        itemBuilder: ((context, index) {
          Task task = tasksList[index];
          return Dismissible(
            background: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Icon(Icons.delete),
                SizedBox(width: 4.0),
                Text(
                  taskDeleted,
                  style: Style.textStyle1,
                ),
              ],
            ),
            onDismissed: (direction) =>
                base.dataStore.deleteTask(task: task),
            key: Key(task.title),
            child: TaskWidget(task: tasksList[index]),
          );
        }),
      );
  }
}