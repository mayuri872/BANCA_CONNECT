import 'dart:convert';

import 'package:dsr_clone/data/models/dar_report/dar_report_model.dart';
import 'package:dsr_clone/data/models/dar_report/mark_attendance_model.dart';
import 'package:dsr_clone/data/models/login/manager_dashboard_model.dart';
import 'package:dsr_clone/modules/manger/dar_manager_modules/reports/models/manager_data_model.dart';
import 'package:dsr_clone/modules/manger/dar_manager_modules/reports/models/zone_model.dart';
import 'package:dsr_clone/modules/user/dar_user_modules/dar_activity/models/agent_lead_activity_model.dart';
import 'package:get/get_connect/connect.dart';

import '../../../environment/environment.dart';
import '../../../modules/user/dar_user_modules/potential_agent_lead/models/competition_info_model.dart';
import '../../../modules/user/dar_user_modules/potential_agent_lead/models/subtype_of_activity_model.dart';
import '../../../modules/user/dar_user_modules/potential_customer_lead/models/customer_lead_model.dart';
import '../../../modules/user/dar_user_modules/potential_customer_lead/models/proposed_product_model.dart';
import 'api_endpoint.dart';

class GetNetworkProvider extends GetConnect {
  String? baseurl = Environment().config?.baseurl;

  Future<dynamic> getDAR({
    required RequestDailyAcitivityReport payload,
    required Function(List<ResponseDailyActivityReport> dailyActivityList)
        onSuccess,
    required Function(String? error) onFailed,
  }) async {
    try {
      String resourcesUrl = (baseurl! + ApiEndPoints().dailyActivityReport);

      final res = await post(
        resourcesUrl,
        payload.toJson(),
      );

      if (res.statusCode == 200) {
        var responseDataJson = jsonDecode(res.bodyString ?? '');
        if (responseDataJson['ResponseFlag'] == 1) {
          var nestedResponseJson =
              jsonDecode(responseDataJson['ResponseMessage']);
          List<ResponseDailyActivityReport> dailyAcivityList =
              (nestedResponseJson['Table'] as List)
                  .map((item) => ResponseDailyActivityReport.fromJson(item))
                  .toList();
          onSuccess(dailyAcivityList);
        } else {
          onFailed(responseDataJson['errorDescription']);
        }
      } else {
        onFailed('Failed to get data');
        return;
      }
    } catch (e) {
      onFailed('Failed to get data');
      return;
    }
  }

  Future<dynamic> getAgentLeadDetailsProvider({
    required RequestAgentLeadActivity payload,
    required Function(List<ResponseDailyActivityReport> agentleadActivityList)
        onSuccess,
    required Function(String? error) onFailed,
  }) async {
    try {
      String resourcesUrl = (baseurl! + ApiEndPoints().getAgentLead);

      final res = await post(
        resourcesUrl,
        payload.toJson(),
      );
      if (res.statusCode == 200) {
        var responseDataJson = jsonDecode(res.bodyString ?? '');
        if (responseDataJson['ResponseFlag'] == 1) {
          var nestedResponseJson =
              jsonDecode(responseDataJson['ResponseMessage']);
          List<ResponseDailyActivityReport> agentleadctivityList =
              (nestedResponseJson['Table'] as List)
                  .map((item) => ResponseDailyActivityReport.fromJson(item))
                  .toList();
          onSuccess(agentleadctivityList);
        } else {
          onFailed(responseDataJson['errorDescription']);
        }
      } else {
        onFailed('Failed to get Agent Lead details!');
        return;
      }
    } catch (e) {
      onFailed('Failed to get Agent Lead details!');
      return;
    }
  }

  Future<dynamic> getDSRAgntLeadsdtlsProvider({
    required RequestDailyAcitivityReport payload,
    required Function(List<ResponseDailyActivityReport> agentleadActivityList)
        onSuccess,
    required Function(String? error) onFailed,
  }) async {
    try {
      String resourcesUrl = (baseurl! + ApiEndPoints().getDSRAgntLeadsdtls);

      final res = await post(
        resourcesUrl,
        payload.toJson(),
      );
      if (res.statusCode == 200) {
        var responseDataJson = jsonDecode(res.bodyString ?? '');
        if (responseDataJson['ResponseFlag'] == 1) {
          var nestedResponseJson =
              jsonDecode(responseDataJson['ResponseMessage']);
          List<ResponseDailyActivityReport> agentleadctivityList =
              (nestedResponseJson['Table'] as List)
                  .map((item) => ResponseDailyActivityReport.fromJson(item))
                  .toList();
          onSuccess(agentleadctivityList);
        } else {
          onFailed(responseDataJson['errorDescription']);
        }
      } else {
        onFailed('Failed to get Agent Lead details!');
        return;
      }
    } catch (e) {
      onFailed('Failed to get Agent Lead details!');
      return;
    }
  }

  Future<dynamic> getDSRCustomerLeadsdtlsProvider({
    required RequestDailyAcitivityReport payload,
    required Function(List<ResponseDailyActivityReport> agentleadActivityList)
        onSuccess,
    required Function(String? error) onFailed,
  }) async {
    try {
      String resourcesUrl = (baseurl! + ApiEndPoints().getDSRCustomerLeadsdtls);

      final res = await post(
        resourcesUrl,
        payload.toJson(),
      );
      if (res.statusCode == 200) {
        var responseDataJson = jsonDecode(res.bodyString ?? '');
        if (responseDataJson['ResponseFlag'] == 1) {
          var nestedResponseJson =
              jsonDecode(responseDataJson['ResponseMessage']);
          List<ResponseDailyActivityReport> agentleadctivityList =
              (nestedResponseJson['Table'] as List)
                  .map((item) => ResponseDailyActivityReport.fromJson(item))
                  .toList();
          onSuccess(agentleadctivityList);
        } else {
          onFailed(responseDataJson['errorDescription']);
        }
      } else {
        onFailed('Failed to get Agent Lead details!');
        return;
      }
    } catch (e) {
      onFailed('Failed to get Agent Lead details!');
      return;
    }
  }

  Future<dynamic> getCustomerLeadDetailsProvider({
    required RequestAgentLeadActivity payload,
    required Function(
            List<ResponseDailyActivityReport> customerleadActivityList)
        onSuccess,
    required Function(String? error) onFailed,
  }) async {
    try {
      String resourcesUrl = (baseurl! + ApiEndPoints().getCustomerLead);

      final res = await post(
        resourcesUrl,
        payload.toJson(),
      );

      if (res.statusCode == 200) {
        var responseDataJson = jsonDecode(res.bodyString ?? '');
        if (responseDataJson['ResponseFlag'] == 1) {
          var nestedResponseJson =
              jsonDecode(responseDataJson['ResponseMessage']);
          List<ResponseDailyActivityReport> customerleadActivityList =
              (nestedResponseJson['Table'] as List)
                  .map((item) => ResponseDailyActivityReport.fromJson(item))
                  .toList();
          onSuccess(customerleadActivityList);
        } else {
          onFailed(responseDataJson['errorDescription']);
        }
      } else {
        onFailed('Failed to get Customer Lead details!');
      }
    } catch (e) {
      // Print the error
      onFailed('Failed to get Customer Lead details!');
    }
  }

  Future<dynamic> getAttendanceStatusProvider({
    required RequestMarkAttendance payload,
    required Function(List<ResponceGetAttendace> attendanceList) onSuccess,
    required Function(String? error) onFailed,
  }) async {
    try {
      String resourcesUrl = (baseurl! + ApiEndPoints().getAttendanceStatus);

      final res = await post(
        resourcesUrl,
        payload.toJson(),
      );

      if (res.statusCode == 200) {
        var responseDataJson = jsonDecode(res.bodyString ?? '');
        int responseFlag = responseDataJson['ResponseFlag'];

        if (responseFlag == 1) {
          var nestedResponseJson =
              jsonDecode(responseDataJson['ResponseMessage']);
          List<ResponceGetAttendace> attList =
              (nestedResponseJson['Table'] as List)
                  .map((item) => ResponceGetAttendace.fromJson(item))
                  .toList();
          onSuccess(attList);
        } else {
          onFailed(responseDataJson['errorDescription']);
        }
      } else {
        onFailed('Failed to get data');
        return;
      }
    } catch (e) {
      onFailed('Failed to get data');
      return;
    }
  }

  Future<dynamic> getSubTypeOfActivityProvider({
    required RequestSubTypeOfActivity request,
    required Function(List<ResponceSubTypeOfActivity> responceSubTypeDataList)
        onSuccess,
    required Function(String? error) onFailed,
  }) async {
    try {
      String resourcesUrl = (baseurl! + ApiEndPoints().getSubTypeOfAct);
      final res = await post(
        resourcesUrl,
        request.toJson(),
      );

      if (res.statusCode == 200) {
        var responseDataJson = jsonDecode(res.bodyString ?? '');
        if (responseDataJson['ResponseFlag'] == 1) {
          var nestedResponseJson =
              jsonDecode(responseDataJson['ResponseMessage']);
          List<ResponceSubTypeOfActivity> subTypeActivityResponceList =
              (nestedResponseJson['Table'] as List)
                  .map((item) => ResponceSubTypeOfActivity.fromJson(item))
                  .toList();
          onSuccess(subTypeActivityResponceList);
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

  Future<dynamic> getCompetitionInfoProvider({
    required Function(
            List<ResponceCompetitionInfo> responceCompetitionInfoDataList)
        onSuccess,
    required Function(String? error) onFailed,
  }) async {
    try {
      String resourcesUrl = (baseurl! + ApiEndPoints().getCompetitionInfo);

      final res = await get(resourcesUrl);

      if (res.statusCode == 200) {
        var responseDataJson = jsonDecode(res.bodyString ?? '');
        if (responseDataJson['ResponseFlag'] == 1) {
          var nestedResponseJson =
              jsonDecode(responseDataJson['ResponseMessage']);
          List<ResponceCompetitionInfo> responceList =
              (nestedResponseJson['Table'] as List)
                  .map((item) => ResponceCompetitionInfo.fromJson(item))
                  .toList();
          onSuccess(responceList);
        } else {
          onFailed(responseDataJson['errorDescription']);
        }
      } else {
        onFailed(
            'Failed to get competition info! Status code: ${res.statusCode}');
      }
    } catch (e) {
      onFailed('Failed to get competition info! Error: $e');
    }
  }

  Future<dynamic> getProposedProductProvider({
    required Function(List<ResponceProposedProduct> responceProposedProduct)
        onSuccess,
    required Function(String? error) onFailed,
  }) async {
    try {
      String resourcesUrl = (baseurl! + ApiEndPoints().getDSRProductMst);

      final res = await get(resourcesUrl);

      if (res.statusCode == 200) {
        var responseDataJson = jsonDecode(res.bodyString ?? '');
        if (responseDataJson['ResponseFlag'] == 1) {
          var nestedResponseJson =
              jsonDecode(responseDataJson['ResponseMessage']);
          List<ResponceProposedProduct> responceList =
              (nestedResponseJson['Table'] as List)
                  .map((item) => ResponceProposedProduct.fromJson(item))
                  .toList();
          onSuccess(responceList);
        } else {
          onFailed(responseDataJson['errorDescription']);
        }
      } else {
        onFailed(
            'Failed to get competition info! Status code: ${res.statusCode}');
      }
    } catch (e) {
      onFailed('Failed to get competition info! Error: $e');
    }
  }

  //// Manager

  Future<dynamic> getMangerDashDataProvider({
    required RequestManagerDashModel request,
    required Function(List<ResponseManagerDashModel> responseManagerList)
        onSuccess,
    required Function(String? error) onFailed,
  }) async {
    try {
      String resourcesUrl = (baseurl! + ApiEndPoints().getDSRleaders);
      final res = await post(
        resourcesUrl,
        request.toJson(),
      );

      if (res.statusCode == 200) {
        var responseDataJson = jsonDecode(res.bodyString ?? '');
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

  Future<dynamic> getLastMonthDataProvider({
    required RequestManagerDashModel request,
    required Function(List<ResponseLastMonthDetails> lasTMonthDataList)
        onSuccess,
    required Function(String? error) onFailed,
  }) async {
    try {
      String resourcesUrl = (baseurl! + ApiEndPoints().getDSRlastMonth);
      final res = await post(
        resourcesUrl,
        request.toJson(),
      );

      if (res.statusCode == 200) {
        var responseDataJson = jsonDecode(res.bodyString ?? '');
        if (responseDataJson['ResponseFlag'] == 1) {
          var nestedResponseJson =
              jsonDecode(responseDataJson['ResponseMessage']);
          List<ResponseLastMonthDetails> lastMonthResponceList =
              (nestedResponseJson['Table'] as List)
                  .map((item) => ResponseLastMonthDetails.fromJson(item))
                  .toList();
          onSuccess(lastMonthResponceList);
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

  Future<dynamic> getYesterdayDataProvider({
    required RequestManagerDashModel request,
    required Function(List<ResponceYesterdayDetails> lasTMonthDataList)
        onSuccess,
    required Function(String? error) onFailed,
  }) async {
    try {
      String resourcesUrl = (baseurl! + ApiEndPoints().getDSRlastday);
      final res = await post(
        resourcesUrl,
        request.toJson(),
      );

      if (res.statusCode == 200) {
        var responseDataJson = jsonDecode(res.bodyString ?? '');
        if (responseDataJson['ResponseFlag'] == 1) {
          var nestedResponseJson =
              jsonDecode(responseDataJson['ResponseMessage']);
          List<ResponceYesterdayDetails> yesterdayResponceList =
              (nestedResponseJson['Table'] as List)
                  .map((item) => ResponceYesterdayDetails.fromJson(item))
                  .toList();
          onSuccess(yesterdayResponceList);
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

  Future<dynamic> getZoneDataProvider({
    required RequestZoneModel request,
    required Function(List<ResponseZoneModel> responceZoneDataList) onSuccess,
    required Function(String? error) onFailed,
  }) async {
    try {
      String resourcesUrl = (baseurl! + ApiEndPoints().getDSRZone);
      final res = await post(
        resourcesUrl,
        request.toJson(),
      );

      if (res.statusCode == 200) {
        var responseDataJson = jsonDecode(res.bodyString ?? '');
        if (responseDataJson['ResponseFlag'] == 1) {
          var nestedResponseJson =
              jsonDecode(responseDataJson['ResponseMessage']);
          List<ResponseZoneModel> zoneResponceList =
              (nestedResponseJson['Table'] as List)
                  .map((item) => ResponseZoneModel.fromJson(item))
                  .toList();
          onSuccess(zoneResponceList);
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

  Future<dynamic> zoneManagerfiltersDataProvider({
    required RequestZoneManagerfiltersModel request,
    required Function(List<ResponseDailyActivityReport> responceZoneDataList)
        onSuccess,
    required Function(String? error) onFailed,
  }) async {
    try {
      String resourcesUrl = (baseurl! + ApiEndPoints().zoneManagerfilters);

      final res = await post(
        resourcesUrl,
        request.toJson(),
      );

      if (res.statusCode == 200) {
        var responseDataJson = jsonDecode(res.bodyString ?? '');
        if (responseDataJson['ResponseFlag'] == 1) {
          var nestedResponseJson =
              jsonDecode(responseDataJson['ResponseMessage']);
          List<ResponseDailyActivityReport> zoneResponceList =
              (nestedResponseJson['Table'] as List)
                  .map((item) => ResponseDailyActivityReport.fromJson(item))
                  .toList();
          onSuccess(zoneResponceList);
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

  Future<dynamic> dSRFilterDataProvider({
    required RequestFilterDataModel request,
    required Function(List<ResponseDailyActivityReport> responceZoneDataList)
        onSuccess,
    required Function(String? error) onFailed,
  }) async {
    try {
      String resourcesUrl = (baseurl! + ApiEndPoints().getdSRFilter);

      final res = await post(
        resourcesUrl,
        request.toJson(),
      );

      if (res.statusCode == 200) {
        var responseDataJson = jsonDecode(res.bodyString ?? '');
        if (responseDataJson['ResponseFlag'] == 1) {
          var nestedResponseJson =
              jsonDecode(responseDataJson['ResponseMessage']);
          List<ResponseDailyActivityReport> zoneResponceList =
              (nestedResponseJson['Table'] as List)
                  .map((item) => ResponseDailyActivityReport.fromJson(item))
                  .toList();
          onSuccess(zoneResponceList);
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

  Future<dynamic> getDSRAgentLeadDtlsProvider({
    required RequestDailyAcitivityReport request,
    required Function(List<ResponseDailyActivityReport> responceAGentDataList)
        onSuccess,
    required Function(String? error) onFailed,
  }) async {
    try {
      String resourcesUrl = (baseurl! + ApiEndPoints().getDSRAgentLeadDtls);
      final res = await post(
        resourcesUrl,
        request.toJson(),
      );

      if (res.statusCode == 200) {
        var responseDataJson = jsonDecode(res.bodyString ?? '');
        if (responseDataJson['ResponseFlag'] == 1) {
          var nestedResponseJson =
              jsonDecode(responseDataJson['ResponseMessage']);
          List<ResponseDailyActivityReport> agentResponceList =
              (nestedResponseJson['Table'] as List)
                  .map((item) => ResponseDailyActivityReport.fromJson(item))
                  .toList();
          onSuccess(agentResponceList);
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

  Future<dynamic> getDSRCustLeadDtlsProvider({
    required RequestDailyAcitivityReport request,
    required Function(List<ResponseDailyActivityReport> responceCustDataList)
        onSuccess,
    required Function(String? error) onFailed,
  }) async {
    try {
      String resourcesUrl = (baseurl! + ApiEndPoints().getDSRCustLeadDtls);
      final res = await post(
        resourcesUrl,
        request.toJson(),
      );

      if (res.statusCode == 200) {
        var responseDataJson = jsonDecode(res.bodyString ?? '');
        if (responseDataJson['ResponseFlag'] == 1) {
          var nestedResponseJson =
              jsonDecode(responseDataJson['ResponseMessage']);
          List<ResponseDailyActivityReport> agentCustResponceList =
              (nestedResponseJson['Table'] as List)
                  .map((item) => ResponseDailyActivityReport.fromJson(item))
                  .toList();
          onSuccess(agentCustResponceList);
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

  Future<dynamic> getAgentDetailsProvider({
    required RequestManagerDashModel request,
    required Function(List<ResponceCustAgentDetails> responceAgentDetails)
        onSuccess,
    required Function(String? error) onFailed,
  }) async {
    try {
      String resourcesUrl = (baseurl! + ApiEndPoints().getDSRAgentDtls);

      //
      final res = await post(
        resourcesUrl,
        request.toJson(),
      );

      if (res.statusCode == 200) {
        var responseDataJson = jsonDecode(res.bodyString ?? '');
        if (responseDataJson['ResponseFlag'] == 1) {
          var nestedResponseJson =
              jsonDecode(responseDataJson['ResponseMessage']);
          List<ResponceCustAgentDetails> responceList =
              (nestedResponseJson['Table'] as List)
                  .map((item) => ResponceCustAgentDetails.fromJson(item))
                  .toList();
          onSuccess(responceList);
        } else {
          onFailed(responseDataJson['errorDescription']);
        }
      } else {
        onFailed('Failed to get data: ${res.statusCode}');
      }
    } catch (e) {
      onFailed('Failed to get data: $e');
    }
  }
///////////////

  Future<dynamic> getLeaderWithZoneDataProvider({
    required RequestManagerModel request,
    required Function(List<ResponseManagerModel> responceManagerDataList)
        onSuccess,
    required Function(String? error) onFailed,
  }) async {
    try {
      String resourcesUrl = (baseurl! + ApiEndPoints().getLeaderDtlsWithZone);

      final res = await post(
        resourcesUrl,
        request.toJson(),
      );

      if (res.statusCode == 200) {
        var responseDataJson = jsonDecode(res.bodyString ?? '');
        if (responseDataJson['ResponseFlag'] == 1) {
          var nestedResponseJson =
              jsonDecode(responseDataJson['ResponseMessage']);
          List<ResponseManagerModel> managerResponceList =
              (nestedResponseJson['Table'] as List)
                  .map((item) => ResponseManagerModel.fromJson(item))
                  .toList();
          onSuccess(managerResponceList);
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
