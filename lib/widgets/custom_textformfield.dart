import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
   CustomTextFormField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.type});
   TextEditingController controller;
   String? hintText;
   String type;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return '$type field is required';
        } else {
          return null;
        }
      },
    );
  }
}
