import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../environment/environment.dart';
import '../../models/dsr_report/dsr_report_model.dart';
import '../../models/login/manager_dashboard_model.dart';
import '../../services/interceptor/token_interceptor.dart';
import 'dsr_api_endpoints.dart';

class GetNetworkProvider extends GetConnect {
  String? baseurl = Environment().config?.baseurl;
  final TokenInterceptor _interceptor = TokenInterceptor();

  Future<dynamic> getDSR({
    required RequestgetDsRdetials payload,
    required Function(List<ResponsegetDsRdetials> dSRdailyActivityList) onSuccess,
    required Function(String? error) onFailed,
  }) async {
    try {
      String resourcesUrl = (baseurl! + DSRApiEndPoints().dSRdailyActivityReport);
      final request = http.Request('POST', Uri.parse(resourcesUrl));
      request.body = jsonEncode(payload.toJson());
      request.headers['Content-Type'] = 'application/json';

      final interceptedRequest = await _interceptor.interceptRequest(request);

      final streamedResponse = await http.Client().send(interceptedRequest);
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        var responseDataJson = jsonDecode(response.body);
        if (responseDataJson['ResponseFlag'] == 1) {
          var nestedResponseJson = jsonDecode(responseDataJson['ResponseMessage']);
          if (nestedResponseJson['Table'] is List) {
            List<ResponsegetDsRdetials> dSRdailyAcivityList = (nestedResponseJson['Table'] as List)
                .map((item) {
                  // Handle subTypeOfActivity field
                  if (item['subTypeOfActivity'] is String && item['subTypeOfActivity'] == "[]") {
                    item['subTypeOfActivity'] = [];
                  }
                  // Ensure all fields are parsed as the correct types
                  item['ID'] = item['ID'].toString();
                  item['team_Leader'] = item['team_Leader'].toString();
                  item['auth_role'] = item['auth_role'].toString();
                  item['userName'] = item['userName'].toString();
                  return ResponsegetDsRdetials.fromJson(item);
                })
                .toList();
            onSuccess(dSRdailyAcivityList);
          } else {
            onFailed('Failed to get DSR details!');
          }
        } else {
          onFailed(responseDataJson['errorDescription']);
        }
      } else {
        onFailed('Failed to get DSR details!');
      }
    } catch (e) {
      onFailed('Failed to get DSR details!');
    }
  }

  Future<dynamic> getSubTypeOfActivity({
    required RequestgetDsRdetials payload,
    required Function(List<DSRSubTypeOfActivity> subTypeOfActivityList) onSuccess,
    required Function(String? error) onFailed,
  }) async {
    try {
      String resourcesUrl = (baseurl! + DSRApiEndPoints().dSRdailyActivityReport);
      final request = http.Request('POST', Uri.parse(resourcesUrl));
      request.body = jsonEncode(payload.toJson());
      request.headers['Content-Type'] = 'application/json';

      final interceptedRequest = await _interceptor.interceptRequest(request);
      final streamedResponse = await http.Client().send(interceptedRequest);
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        var responseDataJson = jsonDecode(response.body);
        if (responseDataJson['ResponseFlag'] == 1) {
          var nestedResponseJson = jsonDecode(responseDataJson['ResponseMessage']);
          if (nestedResponseJson['Table'] is List) {
            List<DSRSubTypeOfActivity> subTypeOfActivityList = (nestedResponseJson['Table'] as List)
                .map((item) {
                  // Handle subTypeOfActivity field
                  if (item['subTypeOfActivity'] is String && item['subTypeOfActivity'] == "[]") {
                    item['subTypeOfActivity'] = [];
                  }
                  // Ensure all fields are parsed as the correct types
                  item['ID'] = item['ID'].toString();
                  item['team_Leader'] = item['team_Leader'].toString();
                  item['auth_role'] = item['auth_role'].toString();
                  item['userName'] = item['userName'].toString();
                  return DSRSubTypeOfActivity.fromJson(item);
                })
                .toList();
            onSuccess(subTypeOfActivityList);
          } else {
            onFailed('Failed to get subtype activities!');
          }
        } else {
          onFailed(responseDataJson['errorDescription']);
        }
      } else {
        onFailed('Failed to get subtype activities!');
      }
    } catch (e) {
      onFailed('Failed to get subtype activities!');
    }
  }

  //// Manager

  Future<dynamic> getDSRMangerDashDataProvider({
    required RequestgetDsRdetials payload,
    required Function(List<ResponseManagerDashModel> responseManagerList)
        onSuccess,
    required Function(String? error) onFailed,
  }) async {
    try {
       String resourcesUrl = 'https://online.futuregenerali.in/TeamTrack/api/MobileApp/getDSRleaders';
      final request = http.Request('POST', Uri.parse(resourcesUrl));
      request.body = jsonEncode(payload.toJson());
      request.headers['Content-Type'] = 'application/json';

      final interceptedRequest = await _interceptor.interceptRequest(request);

      final streamedResponse = await http.Client().send(interceptedRequest);
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        var responseDataJson = jsonDecode(response.body);
        if (responseDataJson['ResponseFlag'] == 1) {
          var nestedResponseJson =
              jsonDecode(responseDataJson['ResponseMessage']);
          List<ResponseManagerDashModel> responseManagerList =
              (nestedResponseJson['Table'] as List)
                  .map((item) => ResponseManagerDashModel.fromJson(item))
                  .toList();
          onSuccess(responseManagerList);
        } else {
          onFailed(responseDataJson['errorDescription']);
        }
      } else {
        onFailed('Failed to get data!');
        return;
      }
    } catch (e) {
      onFailed('Failed to get data!');
      return;
    }
  }
}