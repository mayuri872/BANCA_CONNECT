import 'package:flutter/material.dart';
import '../../../shared/style/app_style.dart';

invalidLoginDialog(BuildContext context, String strError) {
  Widget yesButton = Padding(
    padding: const EdgeInsets.only(left: 20),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 0,
        backgroundColor: AppColors.primary2,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          'Okay',
          style: TextStyle(color: AppColors.white),
        ),
      ),
    ),
  );

  AlertDialog alert = AlertDialog(
    backgroundColor: AppColors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    title: const Icon(
      Icons.help_outline_outlined,
      size: 36,
      color: AppColors.muteIconColor,
    ),
    content: Text(
      strError,
      style: const TextStyle(color: AppColors.black2),
      textAlign: TextAlign.center,
    ),
    actionsPadding: const EdgeInsets.only(bottom: 15),
    actionsAlignment: MainAxisAlignment.center,
    actions: [yesButton],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
