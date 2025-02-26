

import 'dart:convert';
import 'dart:developer';

import 'package:dsr_clone/shared/widget/toast/toast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../data/models/dar_report/dar_report_model.dart';
import '../../../../../data/models/login/manager_dashboard_model.dart';
import '../../../../../data/services/dar_services/get_data_service.dart';
import '../../../../../shared/routes/app_routes.dart';

class ManagerAgentLeadController extends GetxController {
 
  Toast toast = Toast();
  final GetDataServices getManagerDashDataServices = GetDataServices();
  RxList<ResponseManagerDashModel> responceAgentLeadDetails =
      RxList<ResponseManagerDashModel>();

       RxList<ResponseDailyActivityReport> agntLead =
      RxList<ResponseDailyActivityReport>();
  var selectedFlag = 0.obs;

  RxString name = "Dashboard".obs;
  RxBool isDataLoaded = false.obs;
  List<dynamic> pageArray = [];

  @override
  void onInit() {
    super.onInit();
    //getManagerDashData();
    getTeamsLeaders();
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
            responceAgentLeadDetails.value = res;
            isDataLoaded(true);
          },
          onFailed: (error) {
            log(error.toString());
          },
        );
      } catch (e) {
        log('Error fetching manager dashboard data: $e');
      }
    } else {
      await getDSRAgntLeadsdtls(empCode);
      Get.toNamed(AppRoutes.managerAgentLeadActivityReport);
    }
  }

  Future<void> getDSRAgntLeadsdtls(empCode) async {
    if (empCode != null) {
      await getManagerDashDataServices.getDSRAgntLeadsdtlsServices(
        userName: empCode,
        onSuccess: (res) {
          agntLead.value = res;
          isDataLoaded(true);
        },
        onFailed: (error) {
          log(error.toString());
        },
      );
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
}
