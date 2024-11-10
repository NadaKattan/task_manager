import 'package:flutter/material.dart';
import 'package:task_manager/firebase_functions.dart';
import 'package:task_manager/models/task_model.dart';


class TasksProvider with ChangeNotifier {
  List<TaskModel> tasks = [];
  DateTime selectedDate = DateTime.now();
  Future<void> getTasks() async {
    tasks = await FirebaseFunctions.getAllTasksFromFirestore();
    tasks = tasks
        .where(
          (task) =>
              task.date.year == selectedDate.year &&
              task.date.month == selectedDate.month &&
              task.date.day == selectedDate.day,
        )
        .toList();
    notifyListeners();
  }

  void changeDate(selected) {
    selectedDate = selected;
    getTasks();
  }

  // void editTask(desc,title) {
  //   () => showModalBottomSheet(
  //           context: context, builder: (context) => AddBottomSheetTask()),
  //       foregroundColor: Colors.white,
  //       backgroundColor: Colors.blue,
  //     ),AddBottomSheetTask(
  //     desc: desc,
  //     title: title,
  //   );
  //   notifyListeners();
  // }
}
