import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../modules/app/controller/app_controller.dart';
import '../style/app_colors.dart';

Future exitApp(BuildContext context) {
  final AppController appController = Get.put(AppController());
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Exit Application'),
        content: const Text('Are you sure you want to exit the application?'),
        actions: <Widget>[
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(width: 1.0, color: AppColors.primary2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
            child: const Text(
              'No',
              style: TextStyle(color: AppColors.primary2),
            ),
          ),
          const SizedBox(width: 10),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(width: 1.0, color: AppColors.primary2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onPressed: () {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (!kIsWeb) {
                  exit(0);
                } else {
                  appController.logout();
                }
              });
            },
            child: const Text(
              'Yes',
              style: TextStyle(color: AppColors.primary2),
            ),
          ),
        ],
      );
    },
  );
}