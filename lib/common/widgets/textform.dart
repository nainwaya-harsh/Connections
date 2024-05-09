import 'package:connections/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  const CustomTextFormField({super.key, required this.controller,required this.title});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        fillColor: lightGrey,
        filled: true,
        hintText: title,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: lightGrey,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xfffBD57EA)),
          borderRadius: BorderRadius.circular(16),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xfffBD57EA)),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
