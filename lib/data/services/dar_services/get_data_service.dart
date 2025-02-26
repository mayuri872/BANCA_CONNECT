import 'package:dsr_clone/data/models/dar_report/dar_report_model.dart';
import 'package:dsr_clone/data/models/login/manager_dashboard_model.dart';
import 'package:get/get.dart';
import '../../../modules/manger/dar_manager_modules/reports/models/manager_data_model.dart';
import '../../../modules/manger/dar_manager_modules/reports/models/zone_model.dart';
import '../../../modules/user/dar_user_modules/dar_activity/models/agent_lead_activity_model.dart';
import '../../../modules/user/dar_user_modules/potential_agent_lead/models/competition_info_model.dart';
import '../../../modules/user/dar_user_modules/potential_agent_lead/models/subtype_of_activity_model.dart';
import '../../../modules/user/dar_user_modules/potential_customer_lead/models/customer_lead_model.dart';
import '../../../modules/user/dar_user_modules/potential_customer_lead/models/proposed_product_model.dart';
import '../../models/dar_report/mark_attendance_model.dart';
import '../../network/dar_providers/get_network_provider.dart';

class GetDataServices {
  final GetNetworkProvider getNetworkProvider = Get.put(GetNetworkProvider());

  Future<dynamic> getDailyActivityReport({
    required String userName,
    required Function(List<ResponseDailyActivityReport> responseClaimHistory)onSuccess,
    required Function(String? error) onFailed,
  }) async {
    RequestDailyAcitivityReport requestUserNm = RequestDailyAcitivityReport(username: userName);
    await getNetworkProvider.getDAR(
      payload: requestUserNm,
      onSuccess: (darList) async {
        onSuccess(darList);
        return;
      },
      onFailed: (error) {
        onFailed(error);
        return;
      },
    );
  }

  Future<dynamic> getAttendanceStatusServices({
    required String userName,
    required String dateofVisit,
    required Function(List<ResponceGetAttendace> responseGetAttendance)
        onSuccess,
    required Function(String? error) onFailed,
  }) async {
    RequestMarkAttendance requestMarkAtt =
        RequestMarkAttendance(username: userName, dateofvisit: dateofVisit);
    await getNetworkProvider.getAttendanceStatusProvider(
      payload: requestMarkAtt,
      onSuccess: (attendaceList) async {
        onSuccess(attendaceList);
        return;
      },
      onFailed: (error) {
        onFailed(error);
        return;
      },
    );
  }

  Future<dynamic> getManagerDashDataServices({
    required String userName,
    required Function(List<ResponseManagerDashModel> responseManagerDash)
        onSuccess,
    required Function(String? error) onFailed,
  }) async {
    RequestManagerDashModel requestUserName =
        RequestManagerDashModel(username: userName);
    await getNetworkProvider.getMangerDashDataProvider(
      request: requestUserName,
      onSuccess: (managerDashList) async {
        onSuccess(managerDashList);
        return;
      },
      onFailed: (error) {
        onFailed(error);
        return;
      },
    );
  }

  Future<dynamic> getLastMonthDataServices({
    required String userName,
    required Function(List<ResponseLastMonthDetails> responseGetLastMonthData)onSuccess,
    required Function(String? error) onFailed,
  }) async {
    RequestManagerDashModel requestUserName = RequestManagerDashModel(username: userName);
    await getNetworkProvider.getLastMonthDataProvider(
      request: requestUserName,
      onSuccess: (lastMonthDataList) async {
        onSuccess(lastMonthDataList);
        return;
      },
      onFailed: (error) {
        onFailed(error);
        return;
      },
    );
  }

  Future<dynamic> getYesterdayDataServices({
    required String userName,
    required Function(List<ResponceYesterdayDetails> responseGetYesterdayData)
        onSuccess,
    required Function(String? error) onFailed,
  }) async {
    RequestManagerDashModel requestUserName =
        RequestManagerDashModel(username: userName);
    await getNetworkProvider.getYesterdayDataProvider(
      request: requestUserName,
      onSuccess: (yesterdayDataList) async {
        onSuccess(yesterdayDataList);
        return;
      },
      onFailed: (error) {
        onFailed(error);
        return;
      },
    );
  }

  Future<dynamic> getSubTypeOfActivityDataServices({
    required String userName,
    required Function(List<ResponceSubTypeOfActivity> responseSubTypeData)
        onSuccess,
    required Function(String? error) onFailed,
  }) async {
    RequestSubTypeOfActivity requestUserName =
        RequestSubTypeOfActivity(typeOfActivity: userName);
    await getNetworkProvider.getSubTypeOfActivityProvider(
      request: requestUserName,
      onSuccess: (zoneList) async {
        onSuccess(zoneList);
        return;
      },
      onFailed: (error) {
        onFailed(error);
        return;
      },
    );
  }

  Future<dynamic> getDSRAgentLeadDtlsDataServices({
    required String userName,
    required Function(List<ResponseDailyActivityReport> responseAgentData)onSuccess,
    required Function(String? error) onFailed,
  }) async {
    RequestDailyAcitivityReport requestUserName = RequestDailyAcitivityReport(username: userName);
    await getNetworkProvider.getDSRAgentLeadDtlsProvider(
      request: requestUserName,
      onSuccess: (zoneList) async {
        onSuccess(zoneList);
        return;
      },
      onFailed: (error) {
        onFailed(error);
        return;
      },
    );
  }

  Future<dynamic> getDSRCustLeadDtlsDataServices({
    required String userName,
    required Function(List<ResponseDailyActivityReport> responseCustData)
        onSuccess,
    required Function(String? error) onFailed,
  }) async {
    RequestDailyAcitivityReport requestUserName =
        RequestDailyAcitivityReport(username: userName);
    await getNetworkProvider.getDSRCustLeadDtlsProvider(
      request: requestUserName,
      onSuccess: (zoneList) async {
        onSuccess(zoneList);
        return;
      },
      onFailed: (error) {
        onFailed(error);
        return;
      },
    );
  }

  Future<dynamic> getCompetitionInfoDataServices({
    required Function(List<ResponceCompetitionInfo> responseCompetitionInfoData)
        onSuccess,
    required Function(String? error) onFailed,
  }) async {
    await getNetworkProvider.getCompetitionInfoProvider(
      onSuccess: (responseProposedProductList) async {
        onSuccess(responseProposedProductList);
        return;
      },
      onFailed: (error) {
        onFailed(error);
        return;
      },
    );
  }

  Future<dynamic> getProposedProductDataServices({
    required String userName,
    required String leadType,
    required Function(List<ResponceProposedProduct> responseProposedProductData)
        onSuccess,
    required Function(String? error) onFailed,
  }) async {
    await getNetworkProvider.getProposedProductProvider(
      onSuccess: (responseCompetitionInfoList) async {
        onSuccess(responseCompetitionInfoList);
        return;
      },
      onFailed: (error) {
        onFailed(error);
        return;
      },
    );
  }

  Future<dynamic> getAgentDataServices({
    required String userName,
    required Function(List<ResponceCustAgentDetails> responseAgentData)
        onSuccess,
    required Function(String? error) onFailed,
  }) async {
    RequestManagerDashModel requestUserName =
        RequestManagerDashModel(username: userName);
    await getNetworkProvider.getAgentDetailsProvider(
      request: requestUserName,
      onSuccess: (responseAgentList) async {
        onSuccess(responseAgentList);
        return;
      },
      onFailed: (error) {
        onFailed(error);
        return;
      },
    );
  }

  Future<dynamic> getZoneDataServices({
    required String userName,
    required Function(List<ResponseZoneModel> responseZoneData) onSuccess,
    required Function(String? error) onFailed,
  }) async {
    RequestZoneModel requestUserName = RequestZoneModel(username: userName);
    await getNetworkProvider.getZoneDataProvider(
      request: requestUserName,
      onSuccess: (zoneList) async {
        onSuccess(zoneList);
        return;
      },
      onFailed: (error) {
        onFailed(error);
        return;
      },
    );
  }

  Future<dynamic> zoneManagerfiltersDataServices({
    required List<String> managers,
    required List<String> zones,
    required Function(
            List<ResponseDailyActivityReport> responsezoneManagerfiltersData)
        onSuccess,
    required Function(String? error) onFailed,
  }) async {
    RequestZoneManagerfiltersModel requestUserName =
        RequestZoneManagerfiltersModel(managers: managers, zones: zones);
    await getNetworkProvider.zoneManagerfiltersDataProvider(
      request: requestUserName,
      onSuccess: (responsezoneManagerfiltersList) async {
        onSuccess(responsezoneManagerfiltersList);
        return;
      },
      onFailed: (error) {
        onFailed(error);
        return;
      },
    );
  }

  Future<dynamic> dSRFilterDataServices({
    required String id,
    required List<String> zones,
    required List<String> activity,
    required String startDate,
    required String endDate,
    required Function(
            List<ResponseDailyActivityReport> responsezoneManagerfiltersData)
        onSuccess,
    required Function(String? error) onFailed,
  }) async {
    RequestFilterDataModel requestUserName = RequestFilterDataModel(
        userid: id,
        zones: zones,
        activity: activity,
        startDate: startDate,
        endDate: endDate);
    await getNetworkProvider.dSRFilterDataProvider(
      request: requestUserName,
      onSuccess: (responsezoneManagerfiltersList) async {
        onSuccess(responsezoneManagerfiltersList);
        return;
      },
      onFailed: (error) {
        onFailed(error);
        return;
      },
    );
  }

  Future<dynamic> getLeaderWithZoneDataServices({
    required String userName,
    required List<String> zones,
    required Function(List<ResponseManagerModel> responseManagerData) onSuccess,
    required Function(String? error) onFailed,
  }) async {
    RequestManagerModel requestUserName =
        RequestManagerModel(userName: userName, zones: zones);
    await getNetworkProvider.getLeaderWithZoneDataProvider(
      request: requestUserName,
      onSuccess: (managerList) async {
        onSuccess(managerList);
        return;
      },
      onFailed: (error) {
        onFailed(error);
        return;
      },
    );
  }

  Future<dynamic> getAgentLeadActivityServices({
    required String userName,
    required String leadtype,
    required Function(List<ResponseDailyActivityReport> responseAgentLeadData)
        onSuccess,
    required Function(String? error) onFailed,
  }) async {
    RequestAgentLeadActivity requestUserNm =
        RequestAgentLeadActivity(username: userName, leadType: leadtype);
    await getNetworkProvider.getAgentLeadDetailsProvider(
      payload: requestUserNm,
      onSuccess: (agentListList) async {
        onSuccess(agentListList);
        return;
      },
      onFailed: (error) {
        onFailed(error);
        return;
      },
    );
  }

  Future<dynamic> getDSRAgntLeadsdtlsServices({
    required String userName,
    required Function(List<ResponseDailyActivityReport> responseAgentLeadData)
        onSuccess,
    required Function(String? error) onFailed,
  }) async {
    RequestDailyAcitivityReport requestUserNm =
        RequestDailyAcitivityReport(username: userName);
    await getNetworkProvider.getDSRAgntLeadsdtlsProvider(
      payload: requestUserNm,
      onSuccess: (agentListList) async {
        onSuccess(agentListList);
        return;
      },
      onFailed: (error) {
        onFailed(error);
        return;
      },
    );
  }

  Future<dynamic> getDSRCustomerLeadsdtls({
    required String userName,
    required Function(List<ResponseDailyActivityReport> responseAgentLeadData)
        onSuccess,
    required Function(String? error) onFailed,
  }) async {
    RequestDailyAcitivityReport requestUserNm = RequestDailyAcitivityReport(username: userName);
    await getNetworkProvider.getDSRCustomerLeadsdtlsProvider(
      payload: requestUserNm,
      onSuccess: (agentListList) async {
        onSuccess(agentListList);
        return;
      },
      onFailed: (error) {
        onFailed(error);
        return;
      },
    );
  }

  Future<dynamic> getCustomerLeadActivityServices({
    required String userName,
    required String leadtype,
    required Function(List<ResponseDailyActivityReport> responseCustomerLeadHistory)onSuccess,
    required Function(String? error) onFailed,
  }) async {
    RequestAgentLeadActivity requestCustomerLead = RequestAgentLeadActivity(username: userName, leadType: leadtype);
    await getNetworkProvider.getCustomerLeadDetailsProvider(
      payload: requestCustomerLead,
      onSuccess: (customeragentList) async {
        onSuccess(customeragentList);
        return;
      },
      onFailed: (error) {
        onFailed(error);
        return;
      },
    );
  }
}
