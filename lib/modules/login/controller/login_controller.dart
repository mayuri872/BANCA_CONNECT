import 'dart:convert';
import 'dart:math';
import 'package:dsr_clone/data/models/login/login_model.dart';
import 'package:dsr_clone/data/services/common_servces/login_service.dart';
import 'package:dsr_clone/modules/login/view/login_dialog.dart';
import 'package:dsr_clone/shared/constant/ui_string.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/services/interceptor/token_storage.dart';
import '../../../shared/routes/app_routes.dart';

class LoginController extends GetxController {
  final LoginService loginService;
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  var passwordVisible = false.obs;
  var randomString = ''.obs;
  var isVerified = false.obs;
  final TextEditingController captacha = TextEditingController();
    var selectedValue = 'Banca Connect'.obs;
  final List<String> dropdownItems = ['Banca Connect', 'Health Sales Connect'];

   LoginController(this.loginService);

  @override
  void onInit() async {
    super.onInit();
    await buildCaptcha();
    await loadSelectedValue();
  }


   void setSelected(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    selectedValue.value = value;
    await prefs.setString('selectedValue', value);
    print('Selected value set: $value');
  }

  Future<void> loadSelectedValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedValue = prefs.getString('selectedValue');
    if (savedValue != null) {
      selectedValue.value = savedValue;
      print('Loaded selected value: $savedValue');
    }
  }


  void togglePasswordVisibility() {
    passwordVisible.value = !passwordVisible.value;
  }

  buildCaptcha() {
    const letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
    const length = 6;
    final random = Random();
    randomString.value = String.fromCharCodes(List.generate(
        length, (index) => letters.codeUnitAt(random.nextInt(letters.length))));
  }

  void resetVerification() {
    isVerified.value = false;
  }
  
  // login(context) async {
  //   // if (username.text.isEmpty || password.text.isEmpty) {
  //   //   invalidLoginDialog(context, 'Please enter username and password');
  //   //   return;
  //   // }

  //   // if (captacha.text != randomString.value) {
  //   //   invalidLoginDialog(context, 'Invalid CAPTCHA');
  //   //   return;
  //   // }

  //   RequestLogin reqLogin = RequestLogin();
  //   await loginService.doLogin(
  //     body: reqLogin,
  //     onSuccess: (loginRes) async {
  //       SharedPreferences prefs = await SharedPreferences.getInstance();
  //       await prefs.setString('encodedUsername', reqLogin.username!);
  //       WidgetsBinding.instance.addPostFrameCallback((_) {
  //        if (kIsWeb) {
  //         Get.offAndToNamed(AppRoutes.webdashboard);
  //       } else {
  //        Get.offAndToNamed(AppRoutes.dashboard);
  //       }
          
  //       });
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text('Login successful!'),
  //           duration: Duration(seconds: 2),
  //         ),
  //       );
  //     },
  //     onFailed: (error) {
  //       Get.back();
  //       invalidLoginDialog(context, error ?? UiString().invalidLoginAlert);
  //     },
  //   );
  // }

  login(context) async {
  // if (username.text.isEmpty || password.text.isEmpty) {
  //   invalidLoginDialog(context, 'Please enter username and password');
  //   return;
  // }

  // if (captacha.text != randomString.value) {
  //   invalidLoginDialog(context, 'Invalid CAPTCHA');
  //   return;
  // }

  RequestLogin reqLogin = RequestLogin();
  if (selectedValue.value == 'Health Sales Connect') {
    reqLogin.username = base64.encode(utf8.encode(username.text));
    reqLogin.password = base64.encode(utf8.encode(password.text));
  } else {
    reqLogin.username = username.text;
    reqLogin.password = password.text;
  }

  print('Encoded username: ${reqLogin.username}');
  print('Encoded password: ${reqLogin.password}');
  await loginService.doLogin(
    body: reqLogin,
    onSuccess: (loginRes) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('encodedUsername', reqLogin.username!);
      await prefs.setString('Username', username.text);

      if (selectedValue.value == 'Banca Connect') {
        await prefs.setString('response', jsonEncode(loginRes));
        if (loginRes.token != null) {
          await TokenStorage.storeToken(loginRes.token!);
          print('Token stored: ${loginRes.token!}');
        }
      }

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (kIsWeb) {
          Get.offAndToNamed(AppRoutes.webdashboard);
        } else {
          Get.offAndToNamed(AppRoutes.dashboard);
        }
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login successful!'),
          duration: Duration(seconds: 2),
        ),
      );
    },
    onFailed: (error) {
      Get.back();
      print('Login failed: $error');
      invalidLoginDialog(context, error ?? UiString().invalidLoginAlert);
    },
  );
}
}
