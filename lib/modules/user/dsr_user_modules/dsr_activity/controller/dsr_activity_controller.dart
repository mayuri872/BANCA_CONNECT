import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../data/models/dsr_report/dsr_report_model.dart';
import '../../../../../../data/services/dsr_services/get_dsr_data_service.dart';

class DsrActivityController extends GetxController {
  final GetDataServices getDataService = GetDataServices();
  RxList<ResponsegetDsRdetials> responceDSRAcitvityDetails = RxList<ResponsegetDsRdetials>();
  RxList<DSRSubTypeOfActivity> responceSubTypeOfActivityDSRDetails = RxList<DSRSubTypeOfActivity>();
  RxBool isDataLoaded = false.obs;
  RxList<String> subTypeOfAcitivityList = RxList<String>();

  Future<void> getDailyActivityReportDataDSR() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
     String? username = prefs.getString('encodedUsername');
    print('username$username');
    if (username != null) {
      await getDataService.getDSRDailyActivityReport(
        username: int.parse(username), // Convert to int
        onSuccess: (res) {
          responceDSRAcitvityDetails.value = res.cast<ResponsegetDsRdetials>();
          isDataLoaded(true);
        },
        onFailed: (error) {
          log('Error: $error');
        },
      );
    }
  }

  Future<void> getSubTypeOfActivityData(int username) async {
    await getDataService.getSubTypeOfActivityData(
      username: username, // Pass the username parameter
      onSuccess: (res) {
        responceSubTypeOfActivityDSRDetails.value = res.cast<DSRSubTypeOfActivity>();
        subTypeOfAcitivityList.value = res.map((report) => report.subTypeOfActivity!).toList();
        isDataLoaded(true);
      },
      onFailed: (error) {
        log('Error: $error');
      },
    );
  }
}