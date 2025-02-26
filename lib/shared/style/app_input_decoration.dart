import 'package:dsr_clone/shared/style/app_padding.dart';
import 'package:flutter/material.dart';
import 'app_style.dart';

abstract class AppInputDecoration {
  static InputDecoration inputDecorationFormWithBorder({
    String labelText = '',
    String hintText = '',
    bool isFreeze = false,
    IconButton? suffixIcon,
  }) {
    return InputDecoration(
      floatingLabelBehavior: FloatingLabelBehavior.always,
      filled: true,
      fillColor: isFreeze ? AppColors.white1 : AppColors.white,
      contentPadding: AppPadding().inputContentPadding,
      labelText: labelText,
      counterText: '',
      hintText: hintText,
      hintStyle: const TextStyle(
        color: AppColors.muteIconColor,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      labelStyle: const TextStyle(
        color: Color(0xFF6b0903),
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      border:  OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
        borderSide: const BorderSide(color: Colors.black12),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: isFreeze ? Colors.black12 : Colors.black12,
        ),
      ),
      disabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black12),
      ),
      suffixIcon: suffixIcon,
    );
  }

  // static PinTheme pinFieldDecorationNew() {
  //   return PinTheme(
  //     shape: PinCodeFieldShape.box,
  //     borderRadius: BorderRadius.circular(5),
  //     fieldHeight: 40,
  //     fieldWidth: 40,
  //     activeFillColor: Colors.grey.withOpacity(0.30),
  //     inactiveFillColor: Colors.grey.withOpacity(0.30),
  //     selectedFillColor: Colors.grey.withOpacity(0.30),
  //     activeColor: Colors.grey.withOpacity(0.30),
  //     inactiveColor: Colors.grey.withOpacity(0.30),
  //     selectedColor: Colors.grey.withOpacity(0.30),
  //     errorBorderColor: Colors.grey.withOpacity(0.30),
  //     borderWidth: 0,
  //     inactiveBorderWidth: 0,
  //     activeBorderWidth: 0,
  //     selectedBorderWidth: 0,
  //     errorBorderWidth: 0,
  //   );
  // }
}
