import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../data/models/login/manager_dashboard_model.dart';
import '../../../../../data/services/dsr_services/get_dsr_data_service.dart';

class DSRManagerDashboardController extends GetxController {
   final GetDataServices getDSRManagerDashDataServices = GetDataServices();
  RxList<ResponseManagerDashModel> responceDSRMangerDashDetails =
      RxList<ResponseManagerDashModel>();
  RxList<ResponseLastMonthDetails> responceLastMonthList =
      RxList<ResponseLastMonthDetails>();
  RxList<ResponceYesterdayDetails> responceYesterdayList =
      RxList<ResponceYesterdayDetails>();
  RxBool isDataLoaded = false.obs;
  DateTime currentDate = DateTime.now();
  late DateTime yesterdayDate = currentDate.subtract(const Duration(days: 1));

  var yesterdayRecruitmentCount = 0.obs;
  var lastMonthRecruitmentCount = 0.obs;
  var yesterdaySalesCount = 0.obs;
  var lastMonthSalesCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
     getDSRManagerDashData();
  }

  Future<void> getDSRManagerDashData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('encodedUsername');

    if (username != null) {
      //String decodedUsername = utf8.decode(base64.decode(encodedUsername));
      await getDSRManagerDashDataServices.getDSRManagerDashDataServices(
        userName: int.parse(username),
        onSuccess: (res) {
          responceDSRMangerDashDetails.value = res;
          isDataLoaded(true);
        },
        onFailed: (error) {
          log(error.toString());
        },
      );
    }
  }

  // Future<void> getLastMonthData(String id) async {
  //   await getDSRManagerDashDataServices.getLastMonthDataServices(
  //     userName: id,
  //     onSuccess: (res) {
  //       responceLastMonthList.value = res;
  //       updateCountsForLastMonth();
  //       isDataLoaded(true);
  //     },
  //     onFailed: (error) {
  //       log(error.toString());
  //     },
  //   );
  // }

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

  // Future<void> getYesterdayData(String id) async {
  //   await getDSRManagerDashDataServices.getYesterdayDataServices(
  //     userName: id,
  //     onSuccess: (res) {
  //       responceYesterdayList.value = res;
  //       updateCountsForYesterday();
  //       isDataLoaded(true);
  //     },
  //     onFailed: (error) {
  //       log(error.toString());
  //     },
  //   );
  // }

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
