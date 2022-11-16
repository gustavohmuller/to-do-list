import 'package:flutter/material.dart';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

import 'package:to_do_list/main.dart';
import 'package:to_do_list/utils/alerts.dart';
import 'package:to_do_list/utils/strings.dart';

import '../models/task.dart';

class TaskScreen extends StatefulWidget {
  TaskScreen({
    super.key,
    required this.task,
    required this.titleController,
    required this.descriptionController,
  });

  Task? task;
  TextEditingController? titleController = TextEditingController();
  TextEditingController? descriptionController = TextEditingController();

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  String? title;
  String? description;
  DateTime? expirationDate;

  @override
  Widget build(BuildContext context) {
    double widthSize = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const AppBar(),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  const Expanded(
                    child: Divider(
                      color: Color(0XFF2E3440),
                      thickness: 2,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Text(
                    isUpdatingTask() ? addNewTask : updateTask,
                    style: const TextStyle(
                      color: Color(0XFF2E3440),
                      fontSize: 32,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  const Expanded(
                    child: Divider(
                      color: Color(0XFF2E3440),
                      thickness: 2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40.0),
              const Text(
                titleTask,
                style: TextStyle(
                  color: Color(0XFF2E3440),
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextFormField(
                controller: widget.titleController,
                maxLines: 2,
                style: const TextStyle(
                  color: Color(0XFF2E3440),
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0XFF2E3440)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0XFF2E3440)),
                  ),
                ),
                onChanged: (value) => title = value,
                onFieldSubmitted: (value) => title = value,
              ),
              const SizedBox(height: 40.0),
              const Text(
                descriptionTask,
                style: TextStyle(
                  color: Color(0XFF2E3440),
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextFormField(
                controller: widget.descriptionController,
                maxLines: 4,
                style: const TextStyle(
                    color: Color(0XFF2E3440),
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0XFF2E3440)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0XFF2E3440)),
                  ),
                ),
                onChanged: (value) => description = value,
                onFieldSubmitted: (value) => description = value,
              ),
              const SizedBox(height: 40.0),
              GestureDetector(
                onTap: () {
                  DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime.now(),
                      maxTime: DateTime(2050, 12, 31), onConfirm: (date) {
                    setState(() {
                      if (widget.task?.expirationDate == null) {
                        expirationDate = date;
                      } else {
                        widget.task?.expirationDate = date;
                      }
                    });
                    FocusManager.instance.primaryFocus?.unfocus();
                  }, currentTime: showDate(expirationDate));
                },
                child: Container(
                  padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                  width: widthSize,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(
                      color: const Color(0XFF2E3440).withOpacity(0.5),
                    ),
                  ),
                  child: Row(children: [
                    const Text(
                      date,
                      style: TextStyle(
                        color: Color(0XFF2E3440),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Expanded(child: Container()),
                    SizedBox(
                      width: 180,
                      child: Text(
                        showExpirationDate(expirationDate),
                        style: const TextStyle(
                          color: Color(0XFF2E3440),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    )
                  ]),
                ),
              ),
              const SizedBox(height: 40.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0XFF2E3440),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  elevation: 0,
                  padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
                ),
                onPressed: () {
                  if (widget.titleController?.text != null &&
                      widget.descriptionController?.text != null &&
                      widget.titleController!.text.isNotEmpty &&
                      widget.descriptionController!.text.isNotEmpty) {
                    try {
                      // final bool result = BaseWidget.of(context)
                      //     .dataStore
                      //     .updateTask(task: task);
                      // if (result) {
                      //   Navigator.of(context).pop();
                      // } else {
                      //   sameTitleAlert(context);
                      // }
                      widget.titleController?.text = title!;
                      widget.descriptionController?.text = description!;
                      widget.task?.expirationDate = expirationDate!;
                      widget.task?.save();
                      Navigator.of(context).pop();
                    } catch (e) {
                      widget.task?.save();
                      Navigator.of(context).pop();
                    }
                  } else {
                    if (title != null &&
                        description != null &&
                        title!.isNotEmpty &&
                        description!.isNotEmpty) {
                      Task task = Task.createTask(
                        title: title!,
                        description: description!,
                        expirationDate: expirationDate,
                      );
                      final bool result =
                          BaseWidget.of(context).dataStore.addTask(task: task);
                      if (result) {
                        Navigator.of(context).pop();
                      } else {
                        sameTitleAlert(context);
                      }
                    } else {
                      emptyFieldsAlert(context);
                    }
                  }
                },
                child: Text(
                  isUpdatingTask() ? addNewTask : updateTask,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String showExpirationDate(DateTime? expirationDate) {
    if (widget.task?.expirationDate == null) {
      if (expirationDate != null) {
        return DateFormat.yMMMEd().format(expirationDate).toString();
      } else {
        return DateFormat.yMMMEd().format(DateTime.now()).toString();
      }
    } else {
      return DateFormat.yMMMEd().format(widget.task!.expirationDate).toString();
    }
  }

  DateTime showDate(DateTime? date) {
    if (widget.task?.expirationDate == null) {
      if (date == null) {
        return DateTime.now();
      } else {
        return date;
      }
    } else {
      return widget.task!.expirationDate;
    }
  }

  bool isUpdatingTask() {
    if (widget.titleController?.text == null &&
        widget.descriptionController?.text == null) {
      return true;
    } else {
      return false;
    }
  }
}

class AppBar extends StatelessWidget with PreferredSizeWidget {
  const AppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0XFF2E3440),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 0,
            padding: const EdgeInsets.only(right: 12.0),
          ),
          child: Row(
            children: const [
              Icon(
                color: Colors.white,
                size: 40,
                Icons.keyboard_arrow_left_rounded,
              ),
              Text(
                'Go back',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
