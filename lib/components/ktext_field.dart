import 'package:flutter/material.dart';

class KTextField extends StatelessWidget {
  String hint;
  TextEditingController controller;
  bool obscureText = false;
  //void Function()? ontap;
  KTextField(
      {super.key,
      required this.controller,
      required this.hint,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          hintText: hint),
    );
  }
}
