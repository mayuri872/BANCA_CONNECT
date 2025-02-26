import 'package:dsr_clone/shared/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Toast extends GetxController{
  //  var backgroundColor;
  //   var iconName;
  //   var color;
  //   var title;
  //   var message;

  // Toast(String this.title, String this.message, List<String> list);

  // @override
  // void onInit() {
  //   toast(title, message);
  //   super.onInit();
  // }
   
 
 openToast(String title, String message, [String? action]) {
    Color backgroundColor;
    IconData iconName;
    Color color;
    if (action == "success") {
      backgroundColor = AppColors.green;
      iconName = Icons.done_outline_rounded;
      color = Colors.white;
    } else if (action == "warning") {
      backgroundColor = Colors.yellow.shade400;
      iconName = Icons.warning_amber_rounded;
      color = Colors.black;
    } else if (action == "danger") {
      backgroundColor = Colors.red.shade400;
      iconName = Icons.delete_forever_rounded;
      color = Colors.white;
    } else if (action == "error") {
      backgroundColor = Colors.red.shade400;
      iconName = Icons.error_outline_outlined;
      color = Colors.white;
    } else {
      backgroundColor = Colors.grey;
      iconName = Icons.notifications;
      color = Colors.white;
    }
    Get.snackbar(
      title,
      message,
      maxWidth: 500,
      snackPosition: SnackPosition.BOTTOM,
      colorText: color,
      borderRadius: 10,
      backgroundColor: backgroundColor,
      icon: Icon(
        iconName,
        size: 25,
        color: color,
      ),
    );
  }


}