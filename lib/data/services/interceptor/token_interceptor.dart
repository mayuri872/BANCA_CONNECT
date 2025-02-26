import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'token_storage.dart';


class TokenInterceptor {
  Future<http.Request> interceptRequest(http.Request request) async {
    String? token = await TokenStorage.getToken();
    if (token != null) {
      request.headers['Authorization'] = token; // No 'Bearer' prefix
      print('Token added to request headers: $token');
    }
    return request;
  }

  Future<http.Response> handleResponse(http.Response response) async {
    if (response.statusCode == 401) {
      // Handle session expiration
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      await prefs.remove('authData');
      print('Session expired, token removed');
      Get.snackbar('Session expired', 'Please log in again.');
      Get.offAllNamed('/login');
    }
    return response;
  }
}