import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/firebase_functions.dart';
import 'package:task_manager/models/task_model.dart';
import 'package:task_manager/providers/tasks_provider.dart';
import 'package:task_manager/widgets/custom_textformfield.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../providers/user_provider.dart';

class AddBottomSheetTask extends StatefulWidget {
  AddBottomSheetTask(
      {this.taskId, this.title, this.desc, this.edit = false, super.key});
  String? title;
  String? desc;
  String? taskId;
  bool edit;
  @override
  State<AddBottomSheetTask> createState() => _AddBottomSheetTaskState();
}

class _AddBottomSheetTaskState extends State<AddBottomSheetTask> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime selectedTime = DateTime.now();
  var formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();

    // Set a specified string in the titleController
    titleController.text = widget.title ?? "";
    descriptionController.text = widget.desc ?? "";
  }

  @override
  Widget build(BuildContext context) {
    // String userId=Provider.of<UserProvider>(context).currentUser!.id;
    // GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(
          height: MediaQuery.sizeOf(context).height * 0.5,
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Text(
                "Add New Task",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      controller: titleController,
                      hintText: "Enter task title",
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter task title';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextFormField(
                      controller: descriptionController,
                      hintText: "Enter task description",
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter task description';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const Text("Select Time"),
                    InkWell(
                        onTap: () async {
                          DateTime? dateTime = await showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            lastDate:
                                DateTime.now().add(const Duration(days: 365)),
                            initialDate: selectedTime,
                            initialEntryMode: DatePickerEntryMode.calendarOnly,
                          );
                          if (dateTime != null && dateTime != selectedTime) {
                            selectedTime = dateTime;
                            setState(() {});
                          }
                        },
                        child: Text(DateFormat.yMd().format(selectedTime))),
                    const SizedBox(
                      height: 25,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            widget.title != null
                                ? editTask(widget.taskId)
                                : addTask();
                            // Navigator.of(context).pop();
                          }
                        },
                        child: widget.edit
                            ? const Text("edit Task")
                            : const Text("Add Task")),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addTask() {
    FirebaseFunctions.addTaskToFirestore(TaskModel(
            date: selectedTime,
            title: titleController.text,
            description: descriptionController.text),Provider.of<UserProvider>(context,listen: false).currentUser!.id)
        .timeout(Duration(milliseconds: 100), onTimeout: () {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      // ignore: use_build_context_synchronously
      Provider.of<TasksProvider>(context, listen: false).getTasks(Provider.of<UserProvider>(context,listen: false).currentUser!.id);
      Fluttertoast.showToast(
          msg: "Task added successfully",
          toastLength: Toast.LENGTH_SHORT,
          // gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
    }).catchError((e) {
      // print(e);
      Fluttertoast.showToast(
          msg: "Something went wrong",
          toastLength: Toast.LENGTH_SHORT,
          // gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
    });
    // print("add");
  }

  void editTask(taskId) {
    FirebaseFunctions.editTaskInFirestore(
            taskId,
            TaskModel(
                date: selectedTime,
                title: titleController.text,
                description: descriptionController.text),Provider.of<UserProvider>(context,listen: false).currentUser!.id)
        .timeout(Duration(milliseconds: 100), onTimeout: () {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      // ignore: use_build_context_synchronously
      Provider.of<TasksProvider>(context, listen: false).getTasks(Provider.of<UserProvider>(context,listen: false).currentUser!.id);
      Fluttertoast.showToast(
          msg: "Task edited successfully",
          toastLength: Toast.LENGTH_SHORT,
          // gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
    }).catchError((e) {
      Fluttertoast.showToast(
          msg: "Something went wrong",
          toastLength: Toast.LENGTH_SHORT,
          // gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
    });
    // print("add");
  }
}
