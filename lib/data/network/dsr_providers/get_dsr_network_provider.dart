import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../environment/environment.dart';
import '../../models/dsr_report/dsr_report_model.dart';
import '../../services/interceptor/token_interceptor.dart';
import 'dsr_api_endpoints.dart';

class GetNetworkProvider extends GetConnect {
  String? baseurl = Environment().config?.baseurl;
  final TokenInterceptor _interceptor = TokenInterceptor();

  Future<dynamic> getDSR({
    required RequestgetDsRdetials payload,
    required Function(List<ResponsegetDsRdetials> DSRdailyActivityList) onSuccess,
    required Function(String? error) onFailed,
  }) async {
    try {
      String resourcesUrl = (baseurl! + DSRApiEndPoints().DSRdailyActivityReport);
      final request = http.Request('POST', Uri.parse(resourcesUrl));
      request.body = jsonEncode(payload.toJson());
      request.headers['Content-Type'] = 'application/json';

      final interceptedRequest = await _interceptor.interceptRequest(request);
      print('Request Headers: ${interceptedRequest.headers}');
      print('Request Body: ${interceptedRequest.body}');
      final streamedResponse = await http.Client().send(interceptedRequest);
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        print('Status Code: ${response.statusCode}');
        var responseDataJson = jsonDecode(response.body);
        print('Response Data JSON: $responseDataJson');
        if (responseDataJson['ResponseFlag'] == 1) {
          var nestedResponseJson = jsonDecode(responseDataJson['ResponseMessage']);
          print('Nested Response JSON: $nestedResponseJson');
          if (nestedResponseJson['Table'] is List) {
            List<ResponsegetDsRdetials> DSRdailyAcivityList = (nestedResponseJson['Table'] as List)
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
            print('DSR daily activity list retrieved successfully');
            onSuccess(DSRdailyAcivityList);
          } else {
            print('Error: Expected a list in the "Table" field');
            onFailed('Failed to get DSR details!');
          }
        } else {
          print('Error Description: ${responseDataJson['errorDescription']}');
          onFailed(responseDataJson['errorDescription']);
        }
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
        onFailed('Failed to get DSR details!');
      }
    } catch (e) {
      print('Exception: $e');
      onFailed('Failed to get DSR details!');
    }
    print('DSR get provider executed');
  }

  Future<dynamic> getSubTypeOfActivity({
    required RequestgetDsRdetials payload,
    required Function(List<DSRSubTypeOfActivity> subTypeOfActivityList) onSuccess,
    required Function(String? error) onFailed,
  }) async {
    try {
      String resourcesUrl = (baseurl! + DSRApiEndPoints().DSRdailyActivityReport);
      final request = http.Request('POST', Uri.parse(resourcesUrl));
      request.body = jsonEncode(payload.toJson());
      request.headers['Content-Type'] = 'application/json';

      final interceptedRequest = await _interceptor.interceptRequest(request);
      print('Request Headers: ${interceptedRequest.headers}');
      print('Request Body: ${interceptedRequest.body}');
      final streamedResponse = await http.Client().send(interceptedRequest);
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        print('Status Code: ${response.statusCode}');
        var responseDataJson = jsonDecode(response.body);
        print('Response Data JSON: $responseDataJson');
        if (responseDataJson['ResponseFlag'] == 1) {
          var nestedResponseJson = jsonDecode(responseDataJson['ResponseMessage']);
          print('Nested Response JSON: $nestedResponseJson');
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
            print('DSR sub type of activity list retrieved successfully');
            onSuccess(subTypeOfActivityList);
          } else {
            print('Error: Expected a list in the "Table" field');
            onFailed('Failed to get subtype activities!');
          }
        } else {
          print('Error Description: ${responseDataJson['errorDescription']}');
          onFailed(responseDataJson['errorDescription']);
        }
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
        onFailed('Failed to get subtype activities!');
      }
    } catch (e) {
      print('Exception: $e');
      onFailed('Failed to get subtype activities!');
    }
    print('DSR get activity provider executed');
  }
}