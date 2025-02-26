import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../data/models/dar_report/dar_report_model.dart';
import '../../../../../data/models/dar_report/request_save_dar.dart';
import '../../../../../data/services/dar_services/get_data_service.dart';
import '../../../../../data/services/dar_services/post_data_services.dart';
import '../../../../../shared/widget/toast/app_toast.dart';
import '../../../dar_user_modules/potential_agent_lead/models/competition_info_model.dart';


class PotentialAgentLeadController extends GetxController {
  final GetDataServices getDataService = GetDataServices();
  final PostDataServices postDataService = PostDataServices();
  RxBool isDataLoaded = false.obs;
  RxList<ResponseDailyActivityReport> responceAgentLeadDetails =
      RxList<ResponseDailyActivityReport>();
  TextEditingController dateController = TextEditingController();
  TextEditingController totalPremiumController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController personMeetController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController agentNameController = TextEditingController();
  TextEditingController agentContactNoController = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  TextEditingController typeOfActivityController =
      TextEditingController(text: 'Potential Agent Lead');
  RxList<String> competitioninfoList = RxList<String>();
  RxString competitionInfoType = 'Select Competition Information'.obs;
  RxList<ResponceCompetitionInfo> responceCompetitionInfo =
      RxList<ResponceCompetitionInfo>();

        TextEditingController searchController = TextEditingController();
  final isSearching = false.obs;
  final filteredAgentLeadDetails = <ResponseDailyActivityReport>[].obs;

  @override
  void onInit() {
    super.onInit();
    dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    getAgentLeadActivitytData();
    getCompetitionInformationApiData();
    getEmpDetails();
  }
    void filterSearchResults(String query) {
  if (query.isEmpty) {
    filteredAgentLeadDetails.assignAll(responceAgentLeadDetails);
  } else {
    filteredAgentLeadDetails.assignAll(
      responceAgentLeadDetails.where((activity) {
        final typeOfActivity = activity.typeOfActivity!.toLowerCase();
        final dateOfVisit = activity.dateOfVisit != null
            ? DateFormat('yyyy-MM-dd').format(activity.dateOfVisit!).toLowerCase()
            : '';
        return typeOfActivity.contains(query.toLowerCase())||
        dateOfVisit.contains(query.toLowerCase());
      }).toList());
  }
}

  Future<void> getAgentLeadActivitytData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? encodedUsername = prefs.getString('encodedUsername');
    if (encodedUsername != null) {
      String decodedUsername = utf8.decode(base64.decode(encodedUsername));
      await getDataService.getAgentLeadActivityServices(
        leadtype: 'A',
        userName: decodedUsername,
        onSuccess: (res) {
          responceAgentLeadDetails.value = res;
          filteredAgentLeadDetails.assignAll(res);
          isDataLoaded(true);
        },
        onFailed: (error) {
          log(error.toString());
        },
      );
    }
  }

  Future<void> getCompetitionInformationApiData() async {
    await getDataService.getCompetitionInfoDataServices(
      onSuccess: (res) {
        responceCompetitionInfo.value = res;
        competitioninfoList.value =
            res.map((report) => report.insurerName.toString()).toList();
        isDataLoaded(true);
      },
      onFailed: (error) {
        log(error.toString());
      },
    );
  }

  Future<Map<String, String?>> getEmpDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? loginResponseString = prefs.getString('loginResponse');
    if (loginResponseString != null) {
      Map<String, dynamic> loginResponseMap = jsonDecode(loginResponseString);
      String? empName = loginResponseMap['EmpName'];
      String? empCode = loginResponseMap['EmpCode']?.toString().split('.')[0];
      toString();
      String? zone = loginResponseMap['zone'];
      String? reportingManager1Empcode =
          loginResponseMap['ReportingManager1Empcode'];
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

  Future<void> createAgentLeadActivity() async {
    Map<String, String?> empDetails = await getEmpDetails();
    String? empName = empDetails['EmpName'];
    String? empCode = empDetails['EmpCode'];
    String? zone = empDetails['zone'];
    String? reportingManager1Empcode = empDetails['ReportingManager1Empcode'];

    if (empName == null ||
        empCode == null ||
        zone == null ||
        reportingManager1Empcode == null) {
      AppToast.errorToast('Failed to retrieve employee details.');
      return;
    }

    int premiumCollected = 0;
    if (totalPremiumController.text.isNotEmpty) {
      try {
        premiumCollected = int.parse(totalPremiumController.text);
      } catch (e) {
        return;
      }
    }

    RequestSaveDar saveAgentLeadActivityList = RequestSaveDar();
    saveAgentLeadActivityList.executive = empName;
    saveAgentLeadActivityList.teamLeader = reportingManager1Empcode;
    saveAgentLeadActivityList.authRole = 1;
    saveAgentLeadActivityList.userName = num.parse(empCode).toInt();
    saveAgentLeadActivityList.zone = zone;
    saveAgentLeadActivityList.dateOfVisit = DateTime.parse(dateController.text);
    saveAgentLeadActivityList.typeOfActivity = 'LEADS';
    saveAgentLeadActivityList.subTypeOfActivity = '';
    saveAgentLeadActivityList.premiumCollected = premiumCollected;
    saveAgentLeadActivityList.email = emailController.text;
    saveAgentLeadActivityList.meetLocation = locationController.text;
    saveAgentLeadActivityList.competitioninfo = competitionInfoType.toString();
    saveAgentLeadActivityList.toWhomMeet = agentNameController.text;
    saveAgentLeadActivityList.toWhomMeetNumber = agentContactNoController.text;
    saveAgentLeadActivityList.remarkComments = remarkController.text;
    saveAgentLeadActivityList.activityType = 'A';
    saveAgentLeadActivityList.leadStatus = 'P';

    await postDataService.saveAgentLeadActivityServices(
      saveAllDataList: saveAgentLeadActivityList,
      onSuccess: ((success) async {
        AppToast.successToast(success);
        update();
      }),
      onFailed: ((error) {
        AppToast.errorToast(error);
      }),
    );
  }
}
