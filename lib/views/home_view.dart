import 'package:flutter/material.dart';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';

import 'package:to_do_list/main.dart';
import 'package:to_do_list/utils/strings.dart';
import 'package:to_do_list/utils/theme.dart';

import '../components/empty_list.dart';
import '../components/fab.dart';
import '../components/tasks_list.dart';
import '../models/task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchValue = '';
  DateTime startDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .subtract(const Duration(microseconds: 1));
  DateTime endDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .add(const Duration(
              days: 7,
              hours: 23,
              minutes: 59,
              seconds: 59,
              microseconds: 999999));

  final config = CalendarDatePicker2WithActionButtonsConfig(
    calendarType: CalendarDatePicker2Type.range,
    dayTextStyle: Style.textStyle1,
    weekdayLabelTextStyle: Style.textStyle2,
    selectedDayTextStyle: Style.textStyle3,
    selectedDayHighlightColor: const Color(0XFF2E3440),
    closeDialogOnCancelTapped: true,
    cancelButtonTextStyle: Style.textStyle4,
    okButtonTextStyle: Style.textStyle4,
  );

  List<DateTime?> initialValues = [
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
        .add(const Duration(days: 7)),
  ];

  @override
  Widget build(BuildContext context) {
    final base = BaseWidget.of(context);
    return ValueListenableBuilder(
      valueListenable: base.dataStore.listenToTask(),
      builder: (context, tasksBox, child) {
        List<Task> tasksList = tasksBox.values
            .where((item) => item.title.contains(searchValue) ? true : false)
            .where((item) =>
                item.expirationDate.isAfter(startDate) &&
                item.expirationDate.isBefore(endDate))
            .toList();
        tasksList.sort((a, b) => a.expirationDate.compareTo(b.expirationDate));
        return Scaffold(
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    now,
                    style: Style.textStyle2,
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            tasksHeader,
                            style: Style.textStyle5,
                          ),
                          Text(
                            '${numberOfdoneTasks(tasksList)} of ${tasksList.length} done',
                            style: Style.textStyle6,
                          ),
                        ],
                      ),
                      const SizedBox(width: 16.0),
                      SizedBox(
                        width: 30,
                        height: 30,
                        child: CircularProgressIndicator(
                          color: const Color(0XFF2E3440),
                          backgroundColor: Colors.grey[300],
                          value: tasksIndicator(tasksList),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    const Color(0XFF2E3440).withOpacity(0.05),
                                offset: const Offset(0, 3),
                                blurRadius: 16,
                              ),
                            ],
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              suffixIcon: const Icon(
                                Icons.search,
                                color: Color(0XFF2E3440),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                  borderSide: const BorderSide(
                                    width: 0.0,
                                    style: BorderStyle.none,
                                  )),
                              hintText: hintTextSearchBar,
                              hintStyle: Style.textStyle6,
                              fillColor: Colors.white,
                              filled: true,
                            ),
                            style: Style.textStyle1,
                            onChanged: (value) {
                              setState(() {
                                searchValue = value;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0XFF2E3440).withOpacity(0.05),
                              offset: const Offset(0, 3),
                              blurRadius: 16,
                            ),
                          ],
                        ),
                        child: IconButton(
                          onPressed: () {
                            showCalendar(context);
                          },
                          icon: const Icon(
                            Icons.calendar_month_outlined,
                            color: Color(0XFF2E3440),
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  tasksList.isEmpty
                      ? const EmptyList()
                      : TasksList(tasksList: tasksList, base: base),
                  const SizedBox(height: 60.0),
                ],
              ),
            ),
          ),
          floatingActionButton: const FAB(),
        );
      },
    );
  }

  void showCalendar(BuildContext context) {
    showCalendarDatePicker2Dialog(
      context: context,
      config: config,
      dialogSize: const Size(325, 400),
      borderRadius: BorderRadius.circular(15),
      dialogBackgroundColor: Colors.white,
      initialValue: initialValues,
    ).then((value) {
      if (value != null) {
        return _onSelectionChanged(value);
      }
    });
  }

  numberOfTasks(List<Task> tasksList) {
    if (tasksList.isEmpty) {
      return 1;
    } else {
      return tasksList.length;
    }
  }

  numberOfdoneTasks(List<Task> tasksList) {
    int doneTasks = 0;

    for (Task task in tasksList) {
      if (task.isDone) {
        doneTasks++;
      }
    }

    return doneTasks;
  }

  void _onSelectionChanged(List<DateTime?> args) {
    setState(() {
      if (args.isEmpty) {
        startDate = DateTime(
                DateTime.now().year, DateTime.now().month, DateTime.now().day)
            .subtract(const Duration(microseconds: 1));
        endDate = DateTime(
                DateTime.now().year, DateTime.now().month, DateTime.now().day)
            .add(const Duration(
                hours: 23, minutes: 59, seconds: 59, microseconds: 999999));
      } else {
        startDate = args.first!.subtract(const Duration(microseconds: 1));
        endDate = args.last!.add(const Duration(
            hours: 23, minutes: 59, seconds: 59, microseconds: 999999));
      }
    });
  }

  double tasksIndicator(List<Task> tasksList) {
    return numberOfdoneTasks(tasksList) / numberOfTasks(tasksList);
  }
}