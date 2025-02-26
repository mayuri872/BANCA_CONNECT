import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../modules/app/controller/app_controller.dart';
import '../style/app_colors.dart';

class Dialogs {
  logoutConfirm(String title, String subTitle) {
    final AppController appController = Get.put(AppController());
    return Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        contentPadding: const EdgeInsets.all(20),
        content: SizedBox(
          height: 150,
          width: 150,
          child: Center(
            child: Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary),
                  maxLines: 2,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  subTitle,
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black1),
                  textAlign: TextAlign.center,
                  maxLines: 5,
                ),
                const SizedBox(
                  height: 35,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          closeLoader();
                        },
                        child: const Text('No')),
                    ElevatedButton(
                      onPressed: () {
                        appController.logout();
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(AppColors.primary)),
                      child: const Text(
                        'Yes',
                        style: TextStyle(color: AppColors.white),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
  
  closeLoader() {
    Get.back();
  }
}
