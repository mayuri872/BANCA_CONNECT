// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../data/models/dar_report/dar_report_model.dart';
import '../../../../../data/services/dar_services/get_data_service.dart';
import '../models/manager_data_model.dart';
import '../models/zone_model.dart';

class ReportsController extends GetxController
    with SingleGetTickerProviderMixin {
  late TabController tabController;
  final GetDataServices getDataServices = GetDataServices();
  RxList<ResponseZoneModel> responceZoneList = RxList<ResponseZoneModel>();
  RxList<ResponseManagerModel> responceManagerList = RxList<ResponseManagerModel>();
  RxList<ResponseDailyActivityReport> responceZoneManagerfilters = RxList<ResponseDailyActivityReport>();
  RxList<ResponseDailyActivityReport> dSRFilter = RxList<ResponseDailyActivityReport>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxList<String> managerIdList = RxList<String>();
  DateTime? fromDate;
  DateTime? toDate;
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  final isSearching = false.obs;
  final zoneManagerfilters = <ResponseDailyActivityReport>[].obs;
  final leadersWithZonefilters = <ResponseDailyActivityReport>[].obs;


  RxList<String> zoneList = RxList<String>();
  RxList<String> managerList = RxList<String>();
  RxList<String> activityList = RxList<String>([
    'Recruitment call',
    'Sales call',
  ]);
  bool sort = true;
  bool isZoneSelected = true;

  RxString name = "Dashboard".obs;
  RxBool isDataLoaded = false.obs;
  RxString selectZone = 'Select zone'.obs;
  RxString selectActivity = 'Select Activity'.obs;
  RxString selectManager = 'Select Manager'.obs;
  var selectedManagers = <String>[].obs;
  var selectedzone = <String>[].obs;
  var selectedzoneTab = <String>[].obs;
  var selectedActivityTab = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: 4);
    getZoneApiData();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  Future<void> getZoneApiData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? encodedUsername = prefs.getString('encodedUsername');
    if (encodedUsername != null) {
      String decodedUsername = utf8.decode(base64.decode(encodedUsername));
      await getDataServices.getZoneDataServices(
        userName: decodedUsername,
        onSuccess: (res) {
          responceZoneList.value = res;
          zoneList.value = res.map((report) => report.zone!).toList();
          isDataLoaded(true);
        },
        onFailed: (error) {
          log(error.toString());
        },
      );
    }
  }

  Future<void> getLeadersWithZoneApiData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? encodedUsername = prefs.getString('encodedUsername');
    if (encodedUsername != null) {
      String decodedUsername = utf8.decode(base64.decode(encodedUsername));
      await getDataServices.getLeaderWithZoneDataServices(
        userName: decodedUsername,
        zones: selectedzone.toList(),
        onSuccess: (res) {
          responceManagerList.value = res;
          managerList.value = res.map((report) => report.name!).toList();
          managerIdList.value =
              res.map((report) => report.id!.toString()).toList();
              
          isDataLoaded(true);
        },
        onFailed: (error) {
          log(error.toString());
        },
      );
    }
  }
void filterSearchResults(String query) {
  if (query.isEmpty) {
    zoneManagerfilters.assignAll(responceZoneManagerfilters);
  } else {
    zoneManagerfilters.assignAll(
      responceZoneManagerfilters.where((activity) {
        final typeOfActivity = activity.typeOfActivity!.toLowerCase();
        final dateOfVisit = activity.dateOfVisit != null
            ? DateFormat('yyyy-MM-dd').format(activity.dateOfVisit!).toLowerCase()
            : '';
        return typeOfActivity.contains(query.toLowerCase()) ||
               dateOfVisit.contains(query.toLowerCase());
      }).toList(),
    );
    leadersWithZonefilters.assignAll(
      dSRFilter.where((activity) {
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
  Future<void> zoneManagerfiltersData(id) async {
    await getDataServices.zoneManagerfiltersDataServices(
      managers: id,
      zones: selectedzone.toList(),
      onSuccess: (res) {
        responceZoneManagerfilters.value = res;
        zoneManagerfilters.assignAll(res);
        isDataLoaded(true);
      },
      onFailed: (error) {
        log(error.toString());
      },
    );
    // }
  }

  Future<void> dSRFilterData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? encodedUsername = prefs.getString('encodedUsername');
    if (encodedUsername != null) {
      String decodedUsername = utf8.decode(base64.decode(encodedUsername));
      await getDataServices.dSRFilterDataServices(
        id: decodedUsername,
        activity: selectedActivityTab.toList(),
        zones: selectedzoneTab.toList(),
        startDate: fromDate != null && fromDate.toString().isNotEmpty
            ? fromDate.toString()
            : '',
        endDate: toDate != null && toDate.toString().isNotEmpty
            ? toDate.toString()
            : '',
        onSuccess: (res) {
          dSRFilter.value = res;
          leadersWithZonefilters.assignAll(res);
          isDataLoaded(true);
        },
        onFailed: (error) {
          log(error.toString());
        },
      );
    }
  }

  selectDate(BuildContext context, bool isFromDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      if (isFromDate) {
        fromDate = picked;
        fromDateController.text = picked.toLocal().toString().split(' ')[0];
      } else {
        toDate = picked;
        toDateController.text = picked.toLocal().toString().split(' ')[0];
        if (selectedzoneTab.isEmpty) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Zone is required')),
            );
          }
        }
        dSRFilterData();
      }
    }
  }
}
