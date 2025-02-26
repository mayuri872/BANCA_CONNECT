import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../data/models/login/manager_dashboard_model.dart';
import '../../../../../data/services/dar_services/get_data_service.dart';
import '../../../../../shared/routes/app_routes.dart';
import '../../../../../shared/widget/toast/toast.dart'; // for date format

class TeamsController extends GetxController {
  Toast toast = Toast();
  final GetDataServices getManagerDashDataServices = GetDataServices();
  RxList<ResponseManagerDashModel> responceTeamActivityDetails =
      RxList<ResponseManagerDashModel>();
       RxList<ResponseManagerDashModel> responceMangerDashDetails = RxList<ResponseManagerDashModel>();
  RxList<ResponseLastMonthDetails> responceLastMonthList = RxList<ResponseLastMonthDetails>();
  RxList<ResponceYesterdayDetails> responceYesterdayList = RxList<ResponceYesterdayDetails>();
  late DateTime yesterdayDate = currentDate.subtract(const Duration(days: 1));
  DateTime currentDate = DateTime.now();
  var selectedFlag = 0.obs;

  RxString name = "Dashboard".obs;
  RxBool isDataLoaded = false.obs;
  List<dynamic> pageArray = [];
  var yesterdayRecruitmentCount = 0.obs;
  var lastMonthRecruitmentCount = 0.obs;
  var yesterdaySalesCount = 0.obs;
  var lastMonthSalesCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    //getManagerDashData();
    getTeamsLeaders();
    //getLastMonthData();
  }

  Future<Map<String, String?>> getTeamsLeaders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? loginResponseString = prefs.getString('loginResponse');
    if (loginResponseString != null) {
      Map<String, dynamic> loginResponseMap = jsonDecode(loginResponseString);
      String? empName = loginResponseMap['EmpName'];
      String? empCode = loginResponseMap['EmpCode'].toString().split('.')[0];
      String? zone = loginResponseMap['zone'];
      String? reportingManager1Empcode =
          loginResponseMap['ReportingManager1Empcode'];
      getManagerDashData(loginResponseMap);
      return {
        'EmpName': empName,
        'EmpCode': empCode,
        'zone': zone,
        'ReportingManager1Empcode': reportingManager1Empcode
      };
    }
    return {
      'EmpName': null,
      'EmpCode': null,
      'zone': null,
      'ReportingManager1Empcode': null
    };
  }

  Future<void> getManagerDashData(Map<String, dynamic> item) async {
    log('Received item: $item');

    if (item['page'] == true) {
      return;
    }

    final flagString = item['flag'];
    if (flagString == null) {
      log('Flag is null');
      return;
    }

    final flag = int.tryParse(flagString.toString());
    if (flag == null) {
      log('Flag is not a valid integer');
      return;
    }

    if (flag != 1) {
      pageArray.add(item);
    }

    String? empCode;
    if (item.containsKey('EmpCode')) {
      empCode = item['EmpCode']?.toString().split('.')[0];
    } else if (item.containsKey('id')) {
      empCode = item['id']?.toString();
    }
    if (empCode == null || empCode.isEmpty) {
      log('empCode is null or empty in getManagerDashData');
      log('Item content: $item');
      return;
    }

    if (flag > 1) {
      try {
        await getManagerDashDataServices.getManagerDashDataServices(
          userName: empCode,
          onSuccess: (res) {
            responceTeamActivityDetails.value = res;
            isDataLoaded(true);
          },
          onFailed: (error) {
            log(error.toString());
          },
        );
      } catch (e) {
        log('Error fetching manager dashboard data: $e');
      }
    }
    else {
     // await getDSRCustomerLeadsdtls(empCode);
     await getTeamActivityDashData(empCode);
     await getLastMonthData(empCode);
     await getLastMonthData(empCode);
      Get.toNamed(AppRoutes.teamActivityDashboard);
    }
  }

  Future<void> geAurhtData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? authDataString = prefs.getString('loginResponse');

    if (authDataString != null) {
      String decodedAuthData = utf8.decode(base64.decode(authDataString));
      Map<String, dynamic> authData = jsonDecode(decodedAuthData);

      String userEmpCode = authData['EmpCode'];
      String userFlag = authData['flag'];
      await prefs.setString('userEmpCode', userEmpCode);
      await prefs.setString('userFlag', userFlag);
    }
  }

  Future<void> getTeamActivityDashData(empCode) async {

    if (empCode != null) {

      await getManagerDashDataServices.getManagerDashDataServices(
        userName: empCode,
        onSuccess: (res) {
          responceMangerDashDetails.value = res;
          isDataLoaded(true);
        },
        onFailed: (error) {
          log(error.toString());
        },
      );
    }
  }
    Future<void> getLastMonthData(String id) async {
    await getManagerDashDataServices.getLastMonthDataServices(
      userName: id,
      onSuccess: (res) {
        responceLastMonthList.value = res;
        updateCountsForLastMonth();
        isDataLoaded(true);
      },
      onFailed: (error) {
        log(error.toString());
      },
    );
  }
  void updateCountsForLastMonth() {
    lastMonthRecruitmentCount.value = responceLastMonthList
        .firstWhere((item) => item.typeOfActivity == 'Recruitment Call',
            orElse: () => ResponseLastMonthDetails(
                typeOfActivity: 'Recruitment Call', lastMonthCount: 0))
        .lastMonthCount!;
    lastMonthSalesCount.value = responceLastMonthList
        .firstWhere((item) => item.typeOfActivity == 'Sales Call',
            orElse: () => ResponseLastMonthDetails(
                typeOfActivity: 'Sales Call', lastMonthCount: 0))
        .lastMonthCount!;
  }

  Future<void> getYesterdayData(String id) async {
    await getManagerDashDataServices.getYesterdayDataServices(
      userName: id,
      onSuccess: (res) {
        responceYesterdayList.value = res;
        updateCountsForYesterday();
        isDataLoaded(true);
      },
      onFailed: (error) {
        log(error.toString());
      },
    );
  }

  void updateCountsForYesterday() {
    yesterdayRecruitmentCount.value = responceYesterdayList
        .firstWhere((item) => item.typeOfActivity == 'Recruitment Call',
            orElse: () => ResponceYesterdayDetails(
                typeOfActivity: 'Recruitment Call', yestedayCount: 0))
        .yestedayCount!;
    yesterdaySalesCount.value = responceYesterdayList
        .firstWhere((item) => item.typeOfActivity == 'Sales Call',
            orElse: () => ResponceYesterdayDetails(
                typeOfActivity: 'Sales Call', yestedayCount: 0))
        .yestedayCount!;
  }
}
