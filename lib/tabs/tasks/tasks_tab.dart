import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/app_theme.dart';
import 'package:task_manager/tabs/tasks/task_item.dart';
import 'package:task_manager/tabs/tasks/tasks_provider.dart';

class TasksTab extends StatefulWidget {
  const TasksTab({super.key});

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  // List<TaskItem> tasks = List.generate(
  // List<TaskModel> tasks = [];
  bool shouldGetTasks = true;
  @override
  Widget build(BuildContext context) {
    TasksProvider tasksProvider = Provider.of<TasksProvider>(context);
    if (shouldGetTasks) {
      tasksProvider.getTasks();
      shouldGetTasks = false;
    }
    // print("object");
    double screenHeight = MediaQuery.sizeOf(context).height;
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: screenHeight * 0.15,
              width: double.infinity,
              color: AppTheme.primary,
            ),
            PositionedDirectional(
              start: 15,
              top: 5,
              child: SafeArea(
                child: Text(
                  "To Do List",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.09),
              child: EasyInfiniteDateTimeLine(
                firstDate: DateTime.now().subtract(const Duration(days: 365)),
                focusDate: tasksProvider.selectedDate,
                lastDate: DateTime.now().add(const Duration(days: 365)),
                // activeColor: AppTheme.white,
                showTimelineHeader: false,
                onDateChange: (selectedDate) {
                    tasksProvider.changeDate(selectedDate);
                },
                dayProps: EasyDayProps(
                  dayStructure: DayStructure.dayStrDayNum,
                  width: 60,
                  height: 80,
                  activeDayStyle: DayStyle(
                    dayNumStyle: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(color: AppTheme.primary),
                    dayStrStyle: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(color: AppTheme.primary),
                    decoration: const BoxDecoration(
                        color: AppTheme.white,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                  ),
                  inactiveDayStyle: DayStyle(
                    dayNumStyle: Theme.of(context).textTheme.labelMedium,
                    dayStrStyle: Theme.of(context).textTheme.labelMedium,
                    decoration: const BoxDecoration(
                        color: AppTheme.white,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                  ),
                  todayStyle: DayStyle(
                    dayNumStyle: Theme.of(context).textTheme.labelMedium,
                    dayStrStyle: Theme.of(context).textTheme.labelMedium,
                    decoration: const BoxDecoration(
                        color: AppTheme.white,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                  ),
                ),
                timeLineProps: const EasyTimeLineProps(
                  separatorPadding: 16,
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.only(top: screenHeight * 0.03),
            itemBuilder: (context, index) =>
                TaskItem(taskModel: tasksProvider.tasks[index]),
            itemCount: tasksProvider.tasks.length,
          ),
        ),
      ],
    );
  }

  // Future<void> getTasks() async {
  //   tasks = await FirebaseFunctions.getAllTasksFromFirestore();
  //   setState(() {});
  // }
}
