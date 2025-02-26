import 'dart:convert';

import 'package:dsr_clone/data/models/login/login_model.dart';
import 'package:dsr_clone/data/models/login/response_login.dart';
import 'package:dsr_clone/data/network/dar_providers/api_endpoint.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:get/get_connect/connect.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../environment/environment.dart';
import '../dsr_providers/dsr_api_endpoints.dart';

class LoginNetworkProvider extends GetConnect {
  String? baseurl = Environment().config?.baseurl;
   final key = encrypt.Key.fromUtf8('ponmlkjihgfedcba');
  final iv = encrypt.IV.fromLength(16);

   LoginNetworkProvider();


    String encryptAES(String plainText) {
    final encrypter = encrypt.Encrypter(
        encrypt.AES(key, mode: encrypt.AESMode.ecb, padding: 'PKCS7'));
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    return encrypted.base64;
  }

  String decryptAES(String encryptedText) {
    final encrypter = encrypt.Encrypter(
        encrypt.AES(key, mode: encrypt.AESMode.ecb, padding: 'PKCS7'));
    final decrypted = encrypter.decrypt64(encryptedText, iv: iv);
    return decrypted;
  }

  // Future<dynamic> userLogin({
  //   required RequestLogin body,
  //   required Function(ResponseLogin resMember, RequestLogin body) onSuccess,
  //   required Function(String? error) onFailed,
  // }) async {
  //   try {
  //     String resourcesUrl = (baseurl! + ApiEndPoints().login);

  //     final res = await post(
  //       resourcesUrl,
  //       body.toJson(),
  //     );

  //     var jsonData = jsonDecode(res.bodyString ?? '');

  //     if (jsonData['ResponseFlag'] == 1) {
  //       List<dynamic> tableData =
  //           jsonDecode(jsonData['ResponseMessage'])['Table'];

  //       if (tableData.isNotEmpty) {
  //         ResponseLogin responseLogin = ResponseLogin.fromJson(tableData[0]);

  //         SharedPreferences prefs = await SharedPreferences.getInstance();
  //         await prefs.setString(
  //             'loginResponse', jsonEncode(responseLogin.toJson()));

  //         String? savedLoginResponse = prefs.getString('loginResponse');
  //         if (savedLoginResponse != null) {
  //           // Do something if needed
  //         } else {
  //           // Handle the case where the response is not saved
  //         }

  //         onSuccess(responseLogin, body);
  //       } else {
  //         onFailed('No data found in the response.');
  //       }
  //     } else {
  //       onFailed('Please Enter username and password');
  //     }
  //   } catch (e) {
  //     onFailed('Something went wrong. Please try again.');
  //   }
  // }

 userLogin({
    required RequestLogin body,
    required String userType,
    required Function(ResponseLogin resMember, RequestLogin body) onSuccess,
    required Function(String? error) onFailed,
  }) async {
    if (userType == 'Health Sales Connect') {
      await userLoginHealthSales(
          body: body, onSuccess: onSuccess, onFailed: onFailed);
    } else {
      await userLoginBancaConnect(
          body: body, onSuccess: onSuccess, onFailed: onFailed);
    }
  }

  userLoginHealthSales({
    required RequestLogin body,
    required Function(ResponseLogin resMember, RequestLogin body) onSuccess,
    required Function(String? error) onFailed,
  }) async {
    try {
      String resourcesUrl =
         (baseurl! + ApiEndPoints().login);

      final res = await post(
        resourcesUrl,
        body.toJson(),
      );
      print('Request URL: $resourcesUrl');
      print('Request Body: ${body.toJson()}');
      print('Response: ${res.bodyString}');

      var jsonData = jsonDecode(res.bodyString ?? '');
      if (jsonData['ResponseFlag'] == 1) {
        List<dynamic> tableData = jsonDecode(jsonData['ResponseMessage'])['Table'];
        if (tableData.isNotEmpty) {
          ResponseLogin responseLogin = ResponseLogin.fromJson(tableData[0]);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('loginResponse', jsonEncode(responseLogin.toJson()));
          String? savedLoginResponse = prefs.getString('loginResponse');
          if (savedLoginResponse != null) {
            // Do something if needed
          } else {
            // Handle the case where the response is not saved
          }
          onSuccess(responseLogin, body);
        } else {
          onFailed('No data found in the response.');
        }
      } else {
        onFailed(jsonData['ResponseMessage']);
      }
    } catch (e) {
      print('Error: $e');
      onFailed('Something went wrong. Please try again.');
    }
  }

  userLoginBancaConnect({
    required RequestLogin body,
    required Function(ResponseLogin resMember, RequestLogin body) onSuccess,
    required Function(String? error) onFailed,
  }) async {
    try {
      String resourcesUrl =
          (baseurl! + DSRApiEndPoints().login);
      final encryptedData = encryptAES(jsonEncode(body.toJson()));
      print(jsonEncode(body.toJson()));
      final requestBody = jsonEncode({'request': encryptedData});
      final res = await post(
        resourcesUrl,
        requestBody,
      );
      print('Request URL: $resourcesUrl');
      print('Request Body: $requestBody');
      print('Response: ${res.bodyString}');
      var jsonData = jsonDecode(res.bodyString ?? '');
      if (jsonData['ResponseFlag'] == 1) {
        List<dynamic> tableData = jsonDecode(jsonData['ResponseMessage'])['Table'];
        if (tableData.isNotEmpty) {
          ResponseLogin responseLogin = ResponseLogin.fromJson(tableData[0]);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('loginResponse', jsonEncode(responseLogin.toJson()));
          String? savedLoginResponse = prefs.getString('loginResponse');
          if (savedLoginResponse != null) {
            // Do something if needed
          } else {
            // Handle the case where the response is not saved
          }
          onSuccess(responseLogin, body);
        } else {
          onFailed('No data found in the response.');
        }
      } else {
        onFailed(jsonData['ResponseMessage']);
      }
    } catch (e) {
      print('Error: $e');
      onFailed('Something went wrong. Please try again.');
    }
  }

}
