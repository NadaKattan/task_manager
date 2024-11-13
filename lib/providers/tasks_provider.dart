import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/firebase_functions.dart';
import 'package:task_manager/models/task_model.dart';

class TasksProvider with ChangeNotifier {
  List<TaskModel> tasks = [];
  DateTime selectedDate = DateTime.now();
  Future<void> getTasks(userId) async {
    tasks = await FirebaseFunctions.getAllTasksFromFirestore(userId);
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

  void changeDate(selected,userId) {
    selectedDate = selected;
    getTasks(userId);
  }
 void resetData(){
   tasks = [];
   selectedDate = DateTime.now();
 }
}
