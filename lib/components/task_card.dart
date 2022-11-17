import 'package:flutter/material.dart';

import 'package:msh_checkbox/msh_checkbox.dart';

import 'package:to_do_list/utils/strings.dart';
import 'package:to_do_list/views/task_view.dart';

import '../models/task.dart';
import '../utils/colors.dart';
import '../utils/theme.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({super.key, required this.task});

  final Task task;

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.task.title;
    descriptionController.text = widget.task.description;
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TaskScreen(
              task: widget.task,
              titleController: titleController,
              descriptionController: descriptionController,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color(0XFF2E3440).withOpacity(0.1),
                //color: Color(0XFFD8DEE9).withOpacity(0.5),
                offset: const Offset(0, 3),
                blurRadius: 16,
              ),
            ],
          ),
          child: ListTile(
            leading: MSHCheckbox(
              size: 30,
              value: widget.task.isDone,
              colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                checkedColor: checkbox,
              ),
              style: MSHCheckboxStyle.stroke,
              onChanged: (selected) {
                setState(() {
                  widget.task.isDone = selected;
                });
                widget.task.save();
              },
            ),
            title: Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
              child: Text(
                titleController.text,
                style: TextStyle(
                  color: const Color(0XFF2E3440),
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  decoration:
                      widget.task.isDone ? TextDecoration.lineThrough : null,
                ),
              ),
            ),
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  descriptionController.text,
                  style: TextStyle(
                    color: const Color(0XFF2E3440),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    decoration:
                        widget.task.isDone ? TextDecoration.lineThrough : null,
                  ),
                ),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.square_rounded,
                      color: colorButtom(),
                    ),
                    const SizedBox(width: 4.0),
                    Text(
                      taskExpirationDate(),
                      style: Style.textStyle1,
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color colorButtom() {
    if (widget.task.isDone) {
      return taskDone;
    } else if (widget.task.expirationDate.difference(DateTime.now()).inDays <
        2) {
      return lessThanTwoDays;
    } else if (widget.task.expirationDate.difference(DateTime.now()).inDays <
        4) {
      return lessThanFourDays;
    } else if (widget.task.expirationDate.difference(DateTime.now()).inDays >=
        4) {
      return sevenDaysOrMore;
    }

    return const Color(0XFF2E3440);
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  String taskExpirationDate() {
    if (widget.task.isDone) {
      return done;
    } else if (daysBetween(DateTime.now(), widget.task.expirationDate) < 0) {
      return '${daysBetween(DateTime.now(), widget.task.expirationDate) * -1} $daysExpired';
    } else if (daysBetween(DateTime.now(), widget.task.expirationDate) == 0) {
      return expiresToday;
    } else {
      return '${daysBetween(DateTime.now(), widget.task.expirationDate)} $daysToExpiration';
    }
  }
}
