import 'package:dsr_clone/data/models/dar_report/mark_attendance_model.dart';
import 'package:get/get.dart';

import '../../../shared/constant/ui_string.dart';
import '../../models/dar_report/request_save_dar.dart';
import '../../network/dar_providers/post_network_provider.dart';

class PostDataServices {
  final PostNetworkProvider postNetworkProvider =
      Get.put(PostNetworkProvider());

  Future<dynamic> saveAllData({
    required RequestSaveDar saveAllDetailsList,
    required Function(String success) onSuccess,
    required Function(String error) onFailed,
  }) async {
    await postNetworkProvider.saveAllDARDetails(
      payload: saveAllDetailsList,
      onSuccess: (success) async {
        onSuccess('Saved Data Successfully.');
        return;
      },
      onFailed: (error) {
        onFailed(error ?? UiString().somethingWentWrong);
        return;
      },
    );
  }

  Future<dynamic> markAttednaceDataServices({
    required RequestMarkAttendance requestMarkAttendance,
    required Function(String success) onSuccess,
    required Function(String error) onFailed,
  }) async {
    await postNetworkProvider.markAttendanceProvider(
      payload: requestMarkAttendance,
      onSuccess: (success) async {
        onSuccess('Saved Data Successfully.');
        return;
      },
      onFailed: (error) {
        onFailed(error ?? UiString().somethingWentWrong);
        return;
      },
    );
  }

  Future<dynamic> saveAgentLeadActivityServices({
    required RequestSaveDar saveAllDataList,
    required Function(String success) onSuccess,
    required Function(String error) onFailed,
  }) async {
    await postNetworkProvider.saveAgentLeadActivityProvider(
      payload: saveAllDataList,
      onSuccess: (success) async {
        onSuccess('Saved Data Successfully.');
        return;
      },
      onFailed: (error) {
        onFailed(error ?? UiString().somethingWentWrong);
        return;
      },
    );
  }

  Future<dynamic> saveCustomerLeadActivityServices({
    required RequestSaveDar saveAllDataList,
    required Function(String success) onSuccess,
    required Function(String error) onFailed,
  }) async {
    await postNetworkProvider.saveCustomerLeadActivityProvider(
      payload: saveAllDataList,
      onSuccess: (success) async {
        onSuccess('Saved Data Successfully.');
        return;
      },
      onFailed: (error) {
        onFailed(error ?? UiString().somethingWentWrong);
        return;
      },
    );
  }
}
