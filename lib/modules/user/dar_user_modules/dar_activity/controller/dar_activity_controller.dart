import 'dart:convert';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../data/models/dar_report/dar_report_model.dart';
import '../../../../../data/models/dar_report/mark_attendance_model.dart';
import '../../../../../data/models/dar_report/request_save_dar.dart';
import '../../../../../data/services/dar_services/get_data_service.dart';
import '../../../../../data/services/dar_services/post_data_services.dart';
import '../../../../../shared/widget/toast/app_toast.dart';
import '../../potential_agent_lead/models/subtype_of_activity_model.dart';

class DarActivityController extends GetxController {
  final PostDataServices postDataService = PostDataServices();
  final GetDataServices getDataService = GetDataServices();

  RxString activityType = ''.obs;
  RxString agentLeadType = 'Select Agent Lead'.obs;
  RxString subCategory = 'Select Sub Category'.obs;
  RxString leadType = 'Select Lead Type'.obs;
  RxString subActivityType = 'Select Sub Type Of Activity'.obs;
  RxList<String> subTypeOfAcitivityList = RxList<String>();
  RxList<String> agentLeadDetailsList = RxList<String>();
  RxList<String> custLeadDetailsList = RxList<String>();
  RxString customerLeadType = 'Select Customer Lead'.obs;
  final List<String> activitylist = <String>[
    'Recruitment Call',
    'Sales Call',
  ];
  final List<String> subCategoryList = <String>[
    'Self',
    'Agent Referred',
  ];
  final List<String> leadList = <String>[
    'Self',
    'Manager',
    'Others',
  ];
  TextEditingController searchController = TextEditingController();
  final isSearching = false.obs;
  final filteredActivityDetails = <ResponseDailyActivityReport>[].obs;


  int todayActivityCount = 0;
  int yesterdayActivityCount = 0;
  DateTime maxDate = DateTime.now();
  String? yesterdayDate;

  final TextEditingController dateController = TextEditingController();
  final TextEditingController collectedGStController = TextEditingController();
  //TextEditingController controller = TextEditingController();
  DateTime selectedDate = DateTime.now();

  RxList<ResponceSubTypeOfActivity> responceSubTypeOfActivityDetails = RxList<ResponceSubTypeOfActivity>();
  RxList<ResponseDailyActivityReport> responceDailyAcitvityDetails = RxList<ResponseDailyActivityReport>();
  RxList<ResponceGetAttendace> responceGetAttendace = RxList<ResponceGetAttendace>();
  TextEditingController dateOfVisitController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController personMeetController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController agentNameController = TextEditingController();
  TextEditingController agentContactNoController = TextEditingController();
  TextEditingController reportingManagerController = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  RxBool isDataLoaded = false.obs;

  @override
  void onInit() {
    super.onInit();
    dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    getDailyActivityReportData();
    getAttendanceStatus();
  }

void filterSearchResults(String query) {
  if (query.isEmpty) {
    filteredActivityDetails.assignAll(responceDailyAcitvityDetails);
  } else {
    filteredActivityDetails.assignAll(
      responceDailyAcitvityDetails.where((activity) {
        final typeOfActivity = activity.typeOfActivity!.toLowerCase();
        final dateOfVisit = activity.dateOfVisit != null
            ? DateFormat('yyyy-MM-dd').format(activity.dateOfVisit!).toLowerCase()
            : '';
        return typeOfActivity.contains(query.toLowerCase()) ||
               dateOfVisit.contains(query.toLowerCase());
      }).toList(),
    );
  }
}

  Future<void> getDailyActivityReportData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? encodedUsername = prefs.getString('encodedUsername');
    if (encodedUsername != null) {
      String decodedUsername = utf8.decode(base64.decode(encodedUsername));
      await getDataService.getDailyActivityReport(
        userName: decodedUsername,
        onSuccess: (res) {
          responceDailyAcitvityDetails.value = res;
          filteredActivityDetails.assignAll(res);
          calculateActivityCount(res);
          isDataLoaded(true);
        },
        onFailed: (error) {
          log(error.toString());
        },
      );
    }
  }

  Future<void> getSubTypeOfAcitivityApiData(String selectTypeOfActivity) async {
    await getDataService.getSubTypeOfActivityDataServices(
      userName: selectTypeOfActivity,
      onSuccess: (res) {
        responceSubTypeOfActivityDetails.value = res;
        subTypeOfAcitivityList.value =
            res.map((report) => report.subTypeOfActivity!).toList();
        isDataLoaded(true);
      },
      onFailed: (error) {
        log(error.toString());
      },
    );
  }

  Future<void> getDSRAgentLeadDtlsApiData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? encodedUsername = prefs.getString('encodedUsername');
    if (encodedUsername != null) {
      String decodedUsername = utf8.decode(base64.decode(encodedUsername));
      await getDataService.getDSRAgentLeadDtlsDataServices(
        userName: decodedUsername,
        onSuccess: (res) {
          responceDailyAcitvityDetails.value = res;
          agentLeadDetailsList.value =
              res.map((report) => report.toWhomMeet!).toList();
          isDataLoaded(true);
        },
        onFailed: (error) {
          log(error.toString());
        },
      );
    }
  }

  Future<void> getDSRCustLeadDtlsApiData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? encodedUsername = prefs.getString('encodedUsername');
    if (encodedUsername != null) {
      String decodedUsername = utf8.decode(base64.decode(encodedUsername));
      await getDataService.getDSRCustLeadDtlsDataServices(
        userName: decodedUsername,
        onSuccess: (res) {
          responceDailyAcitvityDetails.value = res;
          custLeadDetailsList.value =
              res.map((report) => report.toWhomMeet!).toList();
          isDataLoaded(true);
        },
        onFailed: (error) {
          log(error.toString());
        },
      );
    }
  }

  Future<Map<String, String?>> getEmpDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? loginResponseString = prefs.getString('loginResponse');
    if (loginResponseString != null) {
      Map<String, dynamic> loginResponseMap = jsonDecode(loginResponseString);
      String? empName = loginResponseMap['EmpName'];
      String? empCode = loginResponseMap['EmpCode'].toString().split('.')[0];
      String? zone = loginResponseMap['zone'];
      String? reportingManager1Empcode = loginResponseMap['ReportingManager1Empcode'];
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

  Future<void> markAttendance() async {
    Map<String, String?> empDetails = await getEmpDetails();

    String? empCode = empDetails['EmpCode'];

    if (empCode == null) {
      AppToast.errorToast('Failed to retrieve employee details.');
      return;
    }
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy').format(now);
    RequestMarkAttendance markAttendanceRequest = RequestMarkAttendance();
    markAttendanceRequest.username = empCode;
    markAttendanceRequest.dateofvisit = formattedDate; //'04/02/2025';
    await postDataService.markAttednaceDataServices(
      requestMarkAttendance: markAttendanceRequest,
      onSuccess: ((success) async {
        AppToast.successToast(success);
      }),
      onFailed: ((error) {
        AppToast.errorToast(error);
      }),
    );
  }

  void calculateActivityCount(List<ResponseDailyActivityReport> allActivityData) async {
    todayActivityCount = 0;
    yesterdayActivityCount = 0;

    for (int i = 0; i < allActivityData.length; i++) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(allActivityData[i].dateOfVisit!);
      String maxDateFormat = DateFormat('yyyy-MM-dd').format(maxDate);
      if (formattedDate == maxDateFormat) {
        todayActivityCount += 1;
      }
      if (formattedDate == yesterdayDate) {
        yesterdayActivityCount += 1;
      }
    }

    if (yesterdayActivityCount < 1) {
      AppToast.errorToast('Oops! You have missed to submit the Daily Activity Report (DAR) for yesterday, hence you are required to apply for attendance regularization or leave via accessing RACE 2.0 and seek approval from your Reporting Manager with a valid explanation!');
    }
    if (todayActivityCount < 3) {
      AppToast.errorToast('Hold On! Your attendance won\'t be recorded unless you have at least three activities!');
    }
  }

  Future<void> addDailyActivityRecord() async {
    Map<String, String?> empDetails = await getEmpDetails();
    String? empName = empDetails['EmpName'];
    String? empCode = empDetails['EmpCode'];
    String? zone = empDetails['zone'];
    String? reportingManager1Empcode =
        empDetails['ReportingManager1Empcode']?.toString().split('.')[0];

    if (empName == null ||
        empCode == null ||
        zone == null ||
        reportingManager1Empcode == null) {
      AppToast.errorToast('Failed to retrieve employee details.');
      return;
    }

    // if (remarkController.text.isEmpty || !remarkController.text.contains('@')) {
    //   AppToast.errorToast('Remark field is required');
    //   return;
    // }

    RequestSaveDar saveAllList = RequestSaveDar();
    saveAllList.executive = empName;
    saveAllList.teamLeader = reportingManager1Empcode;
    saveAllList.authRole = 1;
    saveAllList.userName = num.parse(empCode).toInt();
    saveAllList.zone = zone;
    saveAllList.dateOfVisit = DateTime.parse(dateController.text);
    saveAllList.startTime = '';
    saveAllList.endTime = '';
    saveAllList.accompanied = leadType.toString();
    saveAllList.duration = '';
    saveAllList.agentDetail = agentLeadType.toString();
    saveAllList.typeOfActivity = activityType.toString();
    saveAllList.email = emailController.text;
    saveAllList.meetLocation = locationController.text;
    saveAllList.agentName = agentNameController.text;
    saveAllList.toWhomMeet = personMeetController.text;
    saveAllList.toWhomMeetNumber = agentContactNoController.text;
    saveAllList.remarkComments = remarkController.text;

    List<Map<String, dynamic>> responceSubTypeOfActivityMap = [];
    ResponceSubTypeOfAct responceSubTypeOfActivity = ResponceSubTypeOfAct();
    responceSubTypeOfActivity.subTypeOfActivity = subActivityType.toString();
    responceSubTypeOfActivity.premiumCollected = 10;
    responceSubTypeOfActivityMap.add(responceSubTypeOfActivity.toJson());

    saveAllList.responceSubTypeOfActivity = responceSubTypeOfActivityMap;

    await postDataService.saveAllData(
      saveAllDetailsList: saveAllList,
      onSuccess: ((success) async {
        AppToast.successToast(success);
        update();

        //await markAttendance();
      }),
      onFailed: ((error) {
        AppToast.errorToast(error);
      }),
    );
    getDailyActivityReportData();
  }

  Future<void> getAttendanceStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? encodedUsername = prefs.getString('encodedUsername');
    if (encodedUsername != null) {
      String decodedUsername = utf8.decode(base64.decode(encodedUsername));
      String formattedDate = DateFormat('yyyy-MM-dd').format(maxDate);
      await getDataService.getAttendanceStatusServices(
        dateofVisit: formattedDate,
        userName: decodedUsername,
        onSuccess: (res) {
          responceGetAttendace.value = res;
          isDataLoaded(true);
        },
        onFailed: (error) {
          log(error.toString());
        },
      );
    }
  }
}
