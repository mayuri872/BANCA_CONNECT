import 'package:get/get.dart';

import '../../models/dsr_report/dsr_report_model.dart';
import '../../models/login/manager_dashboard_model.dart';
import '../../network/dsr_providers/get_dsr_network_provider.dart';


// class GetDataServices{
//   final GetNetworkProvider getNetworkProvider =
//       Get.put(GetNetworkProvider());
//   Future<dynamic> getDSRDailyActivityReport({
//     required int username,
//     required Function(List<ResponsegetDsRdetials> responsegetDSRdetails)
//         onSuccess,
//     required Function(String? error) onFailed,
//   }) async {
//     RequestgetDsRdetials requestUserNm =
//         RequestgetDsRdetials(userName: username);
//         print('requestUserNm $requestUserNm');
//     await getNetworkProvider.getDSR(
//       payload: requestUserNm,
//       onSuccess: (darList) async {

//         onSuccess(darList);
//         return;
//       },
//       onFailed: (error) {
//         onFailed(error);
//         return;
//       },
//     );
//     print('dsr get service executed');
    
//   }
//   Future<dynamic> getSubTypeOfActivityData({
//     required int username,
//     required Function(List<DSRSubTypeOfActivity> responseSubTypeOfActivity) onSuccess,
//     required Function(String? error) onFailed,
//   }) async {
//     RequestgetDsRdetials requestUserNm = RequestgetDsRdetials(userName: username);
//     await getNetworkProvider.getSubTypeOfActivity(
//       payload: requestUserNm,
//       onSuccess: (subTypeList) async {
//         onSuccess(subTypeList);
//         return;
//       },
//       onFailed: (error) {
//         onFailed(error);
//         return;
//       },
//     );
//       print('dsr sut type get service executed');
//   }
// }


class GetDataServices {
  final GetNetworkProvider getNetworkProvider = Get.put(GetNetworkProvider());

  Future<dynamic> getDSRDailyActivityReport({
    required int username, // Define the username parameter
    required Function(List<ResponsegetDsRdetials> responsegetDSRdetails) onSuccess,
    required Function(String? error) onFailed,
  }) async {
    RequestgetDsRdetials requestUserNm = RequestgetDsRdetials(userName: username);
    await getNetworkProvider.getDSR(
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

  Future<dynamic> getSubTypeOfActivityData({
    required int username, // Define the username parameter
    required Function(List<DSRSubTypeOfActivity> responseSubTypeOfActivity) onSuccess,
    required Function(String? error) onFailed,
  }) async {
    RequestgetDsRdetials requestUserNm = RequestgetDsRdetials(userName: username);
    await getNetworkProvider.getSubTypeOfActivity(
      payload: requestUserNm,
      onSuccess: (subTypeList) async {
        onSuccess(subTypeList);
        return;
      },
      onFailed: (error) {
        onFailed(error);
        return;
      },
    );
  }

  Future<dynamic> getDSRManagerDashDataServices({
    required int userName,
    required Function(List<ResponseManagerDashModel> responseManagerDash)
        onSuccess,
    required Function(String? error) onFailed,
  }) async {
    RequestgetDsRdetials requestUserName = RequestgetDsRdetials(userName: userName);
    await getNetworkProvider.getDSRMangerDashDataProvider(
      payload: requestUserName,
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
}