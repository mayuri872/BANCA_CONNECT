import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/style/app_colors.dart';
import '../../../shared/style/app_input_decoration.dart';
import '../../../shared/style/app_text_style.dart';
import '../controller/login_controller.dart';

class WebLoginView extends GetView<LoginController> {
  const WebLoginView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.body,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  loginLeftSideImage(context),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: loginForm(context,size),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  loginLeftSideImage(context) {
    return Image.asset(
      'assets/login.png',
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.height * 0.8,
      fit: BoxFit.cover,
    );
  }

  loginForm(context,Size screenSize) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  color: AppColors.black2,
                  offset: Offset(1, 3),
                ),
              ],
            ),
            padding: const EdgeInsets.all(35),
            margin: const EdgeInsets.all(35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                 Text(
                  'Login In Now',
                  style: AppTextStyle.boldText(),
                ),
                 Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    'Please login to continue using our app',
                    style: AppTextStyle.text(),
                  ),
                ),
                const SizedBox(height: 15),
                userTypeDropDown(),
                const SizedBox(height: 15),
                usernameInput(),
                const SizedBox(height: 15),
                passwordInput(),
                const SizedBox(height: 15),
                captchaButton(screenSize),
                const SizedBox(height: 15),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 1,
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
                ),
                const SizedBox(height: 25),
                const Center(
                  child: Text(
                    "© Future Generali India Insurance Company Ltd.",
            style: TextStyle(color: Colors.black45, fontSize: 10),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget userTypeDropDown() {
    return InputDecorator(
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
    );
  }


  Widget usernameInput() {
    String hintTextStr = 'Enter username';
    return TextField(
      controller: controller.username,
      obscureText: false,
      style: const TextStyle(color: AppColors.black),
      decoration: AppInputDecoration.inputDecorationFormWithBorder(
        labelText: hintTextStr,
        hintText: hintTextStr,
      ),
    );
  }

  Widget passwordInput() {
    String hintTextStr = 'Enter password';
    return Obx(() => TextField(
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
        ));
  }

  Widget captchaInput() {
    String hintTextStr = 'Enter Captcha';
    return TextField(
      controller: controller.captacha,
      obscureText: false,
      style: const TextStyle(color: AppColors.black),
      decoration: AppInputDecoration.inputDecorationFormWithBorder(
        labelText: hintTextStr,
        hintText: hintTextStr,
      ),
    );
  }
  Widget captchaButton(Size screenSize) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: screenSize.width * 0.2, 
            child: captchaInput()),
            const SizedBox(
              width: 10.0,
            ),
            SizedBox(
              height: screenSize.height * 0.06,
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
}
