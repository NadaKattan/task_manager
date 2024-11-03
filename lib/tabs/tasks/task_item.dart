import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/app_theme.dart';
import 'package:task_manager/firebase_functions.dart';
import 'package:task_manager/models/task_model.dart';
import 'package:task_manager/tabs/tasks/add_bottom_sheet_task.dart';
import 'package:task_manager/tabs/tasks/tasks_provider.dart';

class TaskItem extends StatefulWidget {
  TaskItem({super.key, required this.taskModel});
  TaskModel taskModel;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool isDone = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showModalBottomSheet(
          context: context,
          builder: (context) => AddBottomSheetTask(
                desc: widget.taskModel.description,
                title: widget.taskModel.title,
                taskId: widget.taskModel.id,
              )),
      child: Container(
          margin: const EdgeInsets.only(bottom: 20, left: 30, right: 30),
          child: Slidable(
            // Specify a key if the Slidable is dismissible.
            key: const ValueKey(0),
            // The start action pane is the one at the left or the top side.
            startActionPane: ActionPane(
              // A motion is a widget used to control how the pane animates.
              motion: const ScrollMotion(),
              // A pane can dismiss the Slidable.
              dismissible: DismissiblePane(onDismissed: () {}),
              // All actions are defined in the children parameter.
              children: [
                // A SlidableAction can have an icon and/or a label.
                SlidableAction(
                  onPressed: (_) {
                    FirebaseFunctions.deleteTaskFromFirestore(
                            widget.taskModel.id)
                        .timeout(Duration(milliseconds: 100), onTimeout: () {
                      Provider.of<TasksProvider>(context, listen: false)
                          .getTasks();
                    }).catchError((e) {
                      print(e);
                    });
                  },
                  backgroundColor: Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
              ],
            ),
            // The child of the Slidable is what the user sees when the
            // component is not dragged.
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppTheme.white,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Row(
                children: [
                  Container(
                    height: 40,
                    width: 3,
                    color: AppTheme.primary,
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.taskModel.title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(widget.taskModel.description),
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isDone = true;
                      });
                    },
                    child: isDone
                        ? Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppTheme.white,
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Text("is Done!",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                        color: AppTheme.green,
                                        fontWeight: FontWeight.w600)),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppTheme.primary,
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: const Icon(
                              Icons.check,
                              color: AppTheme.white,
                            ),
                          ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
