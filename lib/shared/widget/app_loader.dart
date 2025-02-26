import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../style/app_space_between.dart';
import '../style/app_style.dart';

class AppLoader {
  AppLoader._();

  static void popUpLoader(context) {
    showDialog(
      barrierDismissible: false,
      barrierColor: Colors.black12,
      context: context,
      builder: (_) {
        return LoadingAnimationWidget.inkDrop(
          size: 40,
          color: AppColors.primary,
        );
      },
    );
  }

  static Widget onScreenLoader() {
    return Center(
      child: LoadingAnimationWidget.inkDrop(
        size: 40, 
        color: AppColors.primary,
      ),
    );
  }

  static Widget onScreenLoaderWithScaffold({String message = 'Loading..'}) {
    return Scaffold(
      backgroundColor: AppColors.body,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LoadingAnimationWidget.inkDrop(
              size: 40,
              color: AppColors.primary,
            ),
            gapH16,
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                message,
                style: AppTextStyle.surveyPhotoTitleStyle(),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
