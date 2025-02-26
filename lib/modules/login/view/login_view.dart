import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/style/app_style.dart';
import '../../../shared/widget/responsive_util.dart';
import '../controller/login_controller.dart';
import 'mobile_login_view.dart';
import 'web_login_view.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});



  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.body,
      body: ResponsiveWidget(
        mobile: MobileLoginView(),
        desktop: WebLoginView(),
      ),
    );
  }
}
