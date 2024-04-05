import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  const AppTextField(
      {super.key,
      required this.width,
      required this.height,
      required this.controller,
      this.obscureText = false,
      this.inputFormatters,
      this.hintText});
  final double width;
  final double height;
  final bool obscureText;
  final TextEditingController controller;
  final List<TextInputFormatter>? inputFormatters;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide())),
      ),
    );
  }
}
