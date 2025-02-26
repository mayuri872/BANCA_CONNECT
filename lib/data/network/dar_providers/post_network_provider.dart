import 'dart:convert';
import 'package:dsr_clone/data/models/dar_report/mark_attendance_model.dart';
import 'package:dsr_clone/data/network/dar_providers/api_endpoint.dart';
import 'package:dsr_clone/shared/widget/toast/app_toast.dart';
import 'package:get/get_connect/connect.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import '../../../environment/environment.dart';
import '../../models/dar_report/request_save_dar.dart';

class PostNetworkProvider extends GetConnect {
  String? baseurl = Environment().config?.baseurl;

  Future<dynamic> saveAllDARDetails({
    required RequestSaveDar payload,
    required Function(String? success) onSuccess,
    required Function(String? error) onFailed,
  }) async {
    try {
      String resourcesUrl = (baseurl! + ApiEndPoints().addDailyActivity);
      String jsonPayload = jsonEncode(payload.toJson());

      final res = await http.post(
        Uri.parse(resourcesUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonPayload,
      );
      if (res.statusCode == 200) {
        var responseJson = jsonDecode(res.body);

        if (responseJson['ResponseFlag'].toString() == '1') {
          onSuccess('Data inserted successfully');
          AppToast.successToast('Data inserted successfully');
        } else {
          var responseDataJson = jsonDecode(responseJson['ResponseMessage']);
          onFailed(responseDataJson['Table'][0]['opt'].toString());
        }
      } else {
        onFailed('Failed to save data!');
      }
    } catch (e) {
      onFailed('Failed to save data!');
    }
  }

  Future<dynamic> markAttendanceProvider({
    required RequestMarkAttendance payload,
    required Function(String? success) onSuccess,
    required Function(String? error) onFailed,
  }) async {
    try {
      String resourcesUrl =
          'https://online.futuregenerali.in/HealthSalesConnect/api/health/Attendance';
      String jsonPayload = jsonEncode(payload.toJson());

      // Print the URL and request payload

      final res = await http.post(
        Uri.parse(resourcesUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonPayload,
      );

      // Print the response status code and body

      if (res.statusCode == 200) {
        var responseJson = jsonDecode(res.body);

        if (responseJson['ResponseFlag'].toString() == '0') {
          onSuccess('success');
        } else {
          var responseDataJson = jsonDecode(responseJson['ResponseMessage']);
          onFailed(responseDataJson['Table'][0]['opt'].toString());
        }
      } else {
        onFailed('Failed to save data! Status code: ${res.statusCode}');
      }
    } catch (e) {
      // Print the error
      onFailed('Failed to save data! Error: $e');
    }
  }

  Future<dynamic> saveAgentLeadActivityProvider({
    required RequestSaveDar payload,
    required Function(String? success) onSuccess,
    required Function(String? error) onFailed,
  }) async {
    try {
      String resourcesUrl = (baseurl! + ApiEndPoints().addAgendLeadActivity);
      String jsonPayload = jsonEncode(payload.toJson());

      final res = await http.post(
        Uri.parse(resourcesUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonPayload,
      );

      if (res.statusCode == 200) {
        var responseJson = jsonDecode(res.body);

        if (responseJson['ResponseFlag'].toString() == '0') {
          var responseDataJson = jsonDecode(responseJson['ResponseMessage']);
          String message = responseDataJson['Table'][0]['opt'].toString();

          if (message == 'duplicate contact number found') {
            onFailed('Duplicate contact number found.');
          } else {
            onFailed('Failed to save data!');
          }
        } else if (responseJson['ResponseFlag'].toString() == '1') {
          onSuccess('Data inserted successfully.');
        } else {
          onFailed('Failed to save data!');
        }
      } else {
        onFailed('Failed to save data!');
      }
    } catch (e) {
      // Print the error
      onFailed('Failed to save data!');
    }
  }

  Future<dynamic> saveCustomerLeadActivityProvider({
    required RequestSaveDar payload,
    required Function(String? success) onSuccess,
    required Function(String? error) onFailed,
  }) async {
    try {
      String resourcesUrl = (baseurl! + ApiEndPoints().addCustomerLeadActivity);
      String jsonPayload = jsonEncode(payload.toJson());

      final res = await http.post(
        Uri.parse(resourcesUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonPayload,
      );

      if (res.statusCode == 200) {
        var responseJson = jsonDecode(res.body);

        if (responseJson['ResponseFlag'].toString() == '0') {
          var responseDataJson = jsonDecode(responseJson['ResponseMessage']);
          String message = responseDataJson['Table'][0]['opt'].toString();

          if (message == 'duplicate contact number found') {
            onFailed('Duplicate contact number found.');
          } else {
            onFailed('Failed to save data!');
          }
        } else if (responseJson['ResponseFlag'].toString() == '1') {
          onSuccess('Data inserted successfully.');
        } else {
          onFailed('Failed to save data!');
        }
      } else {
        onFailed('Failed to save data!');
      }
    } catch (e) {
      onFailed('Failed to save data!');
    }
  }
}
