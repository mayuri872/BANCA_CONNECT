// ignore_for_file: deprecated_member_use

import 'package:dsr_clone/shared/style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/style/app_input_decoration.dart';
import '../../../shared/style/app_padding.dart';
import '../../../shared/widget/exit_app_pop_up.dart';
import '../controller/login_controller.dart';

class MobileLoginView extends GetView<LoginController> {
  const MobileLoginView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        await exitApp(context);
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                loginImage(context),
                loginFormView(context, size),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget loginFormView(context, Size screenSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Log In Now",
          style: AppTextStyle.boldText(),
        ),
        Text(
          "Please login to continue using our app ",
          style: AppTextStyle.text(),
        ),
        SizedBox(
          height: screenSize.height * 0.03,
        ),
        userTypeDropDown(),
          SizedBox(height: screenSize.height * 0.02),
        usernameInput(),
        SizedBox(height: screenSize.height * 0.02),
        passwordInput(),
        SizedBox(height: screenSize.height * 0.02),
        captchaButton(screenSize),
        SizedBox(height: screenSize.height * 0.02),
        submitButton(context),
        SizedBox(height: screenSize.height * 0.02),
        const Center(
          child: Text(
            "© Future Generali India Insurance Company Ltd.",
            style: TextStyle(color: Colors.black45, fontSize: 10),
          ),
        )
      ],
    );
  }

 Widget userTypeDropDown() {
    print("Building userTypeDropDown");
    return Padding(
      padding: AppPadding().inputPadding,
      child: InputDecorator(
        decoration: AppInputDecoration.inputDecorationFormWithBorder(
          isFreeze: false,
          labelText: 'User Type',
        ),
        child: Obx(() {
          return DropdownButton<String>(
            value: controller.selectedValue.value,
            style: const TextStyle(color: AppColors.black),
            hint: const Text('User Type'),
            underline: Container(),
            icon: const Icon(Icons.keyboard_arrow_down),
            iconEnabledColor: AppColors.black,
            padding: const EdgeInsets.symmetric(horizontal: 0),
            isExpanded: true,
            isDense: true,
            items: controller.dropdownItems.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                controller.setSelected(newValue);
              }
            },
          );
        }),
      ),
    );
  }

  Widget usernameInput() {
    String hintTextStr = 'Enter username';
    return Padding(
      padding: AppPadding().inputPadding,
      child: TextField(
        controller: controller.username,
        obscureText: false,
        style: const TextStyle(color: AppColors.black),
        decoration: AppInputDecoration.inputDecorationFormWithBorder(
          labelText: hintTextStr,
          hintText: hintTextStr,
        ),
      ),
    );
  }

  Widget passwordInput() {
    String hintTextStr = 'Enter password';
    return Padding(
      padding: AppPadding().inputPadding,
      child: Obx(() => TextField(
            controller: controller.password,
            obscureText: !controller.passwordVisible.value,
            style: const TextStyle(color: AppColors.black),
            decoration: AppInputDecoration.inputDecorationFormWithBorder(
              labelText: hintTextStr,
              hintText: hintTextStr,
              suffixIcon: IconButton(
                icon: Icon(
                  controller.passwordVisible.value
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Colors.black,
                  size: 20,
                  
                ),
                onPressed: () {
                  controller.togglePasswordVisibility();
                },
              ),
            ),
          )),
    );
  }

  Widget captchaInput() {
    String hintTextStr = 'Enter Captcha';
    return Padding(
      padding: AppPadding().inputPadding,
      child: TextField(
        controller: controller.captacha,
        obscureText: false,
        style: const TextStyle(color: AppColors.black),
        decoration: AppInputDecoration.inputDecorationFormWithBorder(
          labelText: hintTextStr,
          hintText: hintTextStr,
        ),
      ),
    );
  }

  Widget loginImage(context) {
    return Image.asset(
      "assets/login.png",
      height: MediaQuery.of(context).size.height * 0.23,
      width: MediaQuery.of(context).size.height * 0.3,
    );
  }

  Widget captchaButton(Size screenSize) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: screenSize.width * 0.5, child: captchaInput()),
            SizedBox(
              height: screenSize.height * 0.05,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black45),
                ),
                child: Obx(() => Text(
                      controller.randomString.value,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    )),
              ),
            ),
            IconButton(
              onPressed: () {
                controller.buildCaptcha();
              },
              icon: const Icon(Icons.refresh, color: Colors.black),
            ),
          ],
        ),
      ],
    );
  }

  Widget submitButton(BuildContext context) {
    return Padding(
      padding: AppPadding().inputPadding,
      child: ElevatedButton(
        onPressed: () async {
          controller.login(context);
        },
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.primary2,
          fixedSize: Size(MediaQuery.of(context).size.width, 60.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Text('Login', style: AppTextStyle.btnTextStyleWhite()),
      ),
    );
  }
  
}