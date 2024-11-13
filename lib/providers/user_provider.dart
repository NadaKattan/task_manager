import 'package:flutter/material.dart';
import 'package:task_manager/models/user_model.dart';

class UserProvider with ChangeNotifier {
  UserModel? currentUser;
  void updateUser(user){
    currentUser=user;
    notifyListeners();
  }
}
