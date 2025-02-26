import 'package:flutter/material.dart';

import '../style/app_input_decoration.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Icon? suffixIcon;
  final int? maxLines;
  final Function? onTap;
  final int? maxLength;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.suffixIcon,
    this.maxLines,
    this.onTap,
    this.maxLength,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: AppInputDecoration.inputDecorationFormWithBorder(
        labelText: hintText,
        hintText: hintText,
      ),
      onTap: onTap as void Function()?,
      maxLines: maxLines,
      maxLength: maxLength,
      validator: validator,
    );
  }
}