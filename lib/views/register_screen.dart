import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/app_theme.dart';
import 'package:task_manager/firebase_functions.dart';
import 'package:task_manager/providers/user_provider.dart';
import 'package:task_manager/views/home_screen.dart';
import 'package:task_manager/views/login_screen.dart';
import 'package:task_manager/widgets/custom_textformfield.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const String routeName = "/register";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.sizeOf(context).height * 0.15,
                width: double.infinity,
                color: AppTheme.primary,
              ),
              PositionedDirectional(
                start: 15,
                top: 5,
                child: SafeArea(
                  child: Text(
                    "Register",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ),
            ],
          ),
          Spacer(
            flex: 1,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    controller: nameController,
                    hintText: "Enter your name",
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "name can't be empty";
                      } else if (value.length < 2) {
                        return "name can't be less than 2 characters";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomTextFormField(
                    controller: emailController,
                    hintText: "Enter your email",
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "email can't be empty";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomTextFormField(
                    controller: passwordController,
                    hintText: "Enter your password",
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Password can't be empty";
                      } else if (value.length < 6) {
                        return "Password can't be less than 6 characters";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        register();
                      }
                    },
                    child: const Text("Register"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(LoginScreen.routeName);
                    },
                    child: Text("Already have an account? Login"),
                  ),
                ],
              ),
            ),
          ),
          Spacer(
            flex: 3,
          ),
        ],
      ),
    );
  }
  void register(){
    FirebaseFunctions.register(name: nameController.text, email: emailController.text, password: passwordController.text).then(
      (user) {
        // ignore: use_build_context_synchronously
        Provider.of<UserProvider>(context,listen: false).updateUser(user);
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
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
