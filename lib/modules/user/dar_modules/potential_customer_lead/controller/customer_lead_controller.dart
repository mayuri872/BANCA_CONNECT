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
import '../../../dar_user_modules/potential_customer_lead/models/customer_lead_model.dart';
import '../../../dar_user_modules/potential_customer_lead/models/proposed_product_model.dart';


class CustomerLeadController extends GetxController {
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
      TextEditingController(text: 'Potential Customer Lead');
  RxString subCategory = 'Select Sub Category'.obs;
  RxString proposedProductType = 'Select Competition Information'.obs;
  RxString typOfAgentName = 'Select agent name'.obs;
  RxList<String> proposedProductionList = RxList<String>();
  RxList<String> agentList = RxList<String>();
  RxList<ResponceProposedProduct> responceProposedProductDetails =
      RxList<ResponceProposedProduct>();
  RxList<ResponceCustAgentDetails> responceAgentDetailst =
      RxList<ResponceCustAgentDetails>();
  RxList<ResponseDailyActivityReport> filteredAgentLeadDetails =
      RxList<ResponseDailyActivityReport>();

        TextEditingController searchController = TextEditingController();
  final isSearching = false.obs;
  final filteredCustomerLeadDetails = <ResponseDailyActivityReport>[].obs;
  @override
  void onInit() {
    super.onInit();
    dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    getCustomerLeadActivitytData();
    getproposedProductApiData();
  }

void filterSearchResults(String query) {
  if (query.isEmpty) {
    filteredCustomerLeadDetails.assignAll(responceAgentLeadDetails);
  } else {
    filteredCustomerLeadDetails.assignAll(
      responceAgentLeadDetails.where((activity) {
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
  Future<void> getCustomerLeadActivitytData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? encodedUsername = prefs.getString('encodedUsername');
    if (encodedUsername != null) {
      String decodedUsername = utf8.decode(base64.decode(encodedUsername));
      await getDataService.getCustomerLeadActivityServices(
        leadtype: 'C',
        userName: decodedUsername,
        onSuccess: (res) {
          responceAgentLeadDetails.value = res;
          filteredCustomerLeadDetails.assignAll(res);
          isDataLoaded(true);
        },
        onFailed: (error) {
          log(error.toString());
        },
      );
    }
  }

  Future<void> getproposedProductApiData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? encodedUsername = prefs.getString('encodedUsername');
    if (encodedUsername != null) {
      String decodedUsername = utf8.decode(base64.decode(encodedUsername));
      await getDataService.getProposedProductDataServices(
        leadType: 'C',
        userName: decodedUsername,
        onSuccess: (res) {
          responceProposedProductDetails.value = res;
          proposedProductionList.value =
              res.map((report) => report.productName.toString()).toList();
        },
        onFailed: (error) {
          log(error.toString());
        },
      );
    }
  }

  Future<void> getAgentLeadApiData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? encodedUsername = prefs.getString('encodedUsername');
    if (encodedUsername != null) {
      String decodedUsername = utf8.decode(base64.decode(encodedUsername));
      await getDataService.getAgentDataServices(
        userName: decodedUsername,
        onSuccess: (res) {
          responceAgentDetailst.value = res;
          agentList.value = res.map((report) {
            return '${report.agentName} - ${report.agentCode}';
          }).toList();
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
      String? empCode = loginResponseMap['EmpCode']?.toString().split('.')[0];
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

    RequestSaveDar saveCustomerLeadActivityList = RequestSaveDar();
    saveCustomerLeadActivityList.executive = empName;
    saveCustomerLeadActivityList.teamLeader = reportingManager1Empcode;
    saveCustomerLeadActivityList.authRole = 1;
    saveCustomerLeadActivityList.userName = num.parse(empCode).toInt();
    saveCustomerLeadActivityList.zone = zone;
    saveCustomerLeadActivityList.dateOfVisit =
        DateTime.parse(dateController.text);
    saveCustomerLeadActivityList.typeOfActivity = 'LEADS';
    saveCustomerLeadActivityList.subTypeOfActivity = '';
    saveCustomerLeadActivityList.premiumCollected = premiumCollected;
    saveCustomerLeadActivityList.email = emailController.text;
    saveCustomerLeadActivityList.meetLocation = locationController.text;
    saveCustomerLeadActivityList.competitioninfo =
        proposedProductType.toString();
    saveCustomerLeadActivityList.toWhomMeet = agentNameController.text;
    saveCustomerLeadActivityList.toWhomMeetNumber =
        agentContactNoController.text;
    saveCustomerLeadActivityList.remarkComments = remarkController.text;
    saveCustomerLeadActivityList.activityType = 'C';
    saveCustomerLeadActivityList.leadStatus = 'P';
    saveCustomerLeadActivityList.subCategoryChanged = subCategory.toString();

    await postDataService.saveCustomerLeadActivityServices(
      saveAllDataList: saveCustomerLeadActivityList,
      onSuccess: ((success) async {
        AppToast.successToast(success);
        update();
      }),
      onFailed: ((error) {
        AppToast.errorToast(error);
      }),
    );
  }

  void searchLeads(String query) {
    if (query.isEmpty) {
      filteredAgentLeadDetails.value = responceAgentLeadDetails;
    } else {
      filteredAgentLeadDetails.value = responceAgentLeadDetails.where((lead) {
        return lead.typeOfActivity!
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            lead.leadType!.toLowerCase().contains(query.toLowerCase()) ||
            lead.zone!.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
  }
}
