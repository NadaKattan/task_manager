import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/app_theme.dart';
import 'package:task_manager/providers/tasks_provider.dart';
import 'package:task_manager/views/login_screen.dart';
import '../firebase_functions.dart';
import '../providers/user_provider.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    var textStyle=Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600,color: AppTheme.black);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("LogOut",style: textStyle,),
                GestureDetector(onTap: (){
                  logout();
                },child: Icon(Icons.logout,size: 30)),
              ],
            )
          ],
        ),
      ),
    );
  }

  void logout(){
    FirebaseFunctions.logout().then(
          (user) {
            Provider.of<TasksProvider>(context,listen: false).resetData();
        Provider.of<UserProvider>(context,listen: false).updateUser(null);
        Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
      },
    ).catchError((e){
      String? message;
      if(e is FirebaseAuthException){
        message=e.message;
      }
      Fluttertoast.showToast(
        msg: message??"Something went wrong",
        toastLength: Toast.LENGTH_SHORT,
        // gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 3,
        backgroundColor: AppTheme.red,);
    });
  }
}
