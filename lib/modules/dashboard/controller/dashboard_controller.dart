import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class DashboardController extends GetxController {
//   Toast toast = Toast();
//   bool sort = true;
//   TextEditingController branchCodeControler = TextEditingController(text: '');
//   TextEditingController branchNameControler = TextEditingController(text: '');
//   TextEditingController latitudeControler = TextEditingController(text: '');
//   TextEditingController longitudeControler = TextEditingController(text: '');

//   TextEditingController searchController = TextEditingController();
//   final formKey = GlobalKey<FormState>();

//   RxString name = "Dashboard".obs;
//   RxBool isDataLoaded = false.obs;

//   RxList<DashboardModel> filteredList = <DashboardModel>[].obs;
//   RxList<DashboardModel> barnchMasterList = <DashboardModel>[].obs;
//   RxString flag = "".obs;

//   var sectionData = <Map<String, dynamic>>[
//     {
//       'title': 'Dashboard',
//       'route': AppRoutes.dashboard.toString(),
//       'image': 'assets/dashboard.png'
//     },
//     {
//       'title': 'DSR Activity',
//       'route': AppRoutes.dashboard.toString(),
//       'image': 'assets/dsr.png'
//     },
//     {
//       'title': 'Teams',
//       'route': AppRoutes.dashboard.toString(),
//       'image': 'assets/teams.png'
//     },
//   ].obs;

//   @override
//   void onInit() {
//     filteredList.value = barnchMasterList;
//     super.onInit();
//     _getFlag();
//   }

//   Future<void> _getFlag() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? loginResponseString = prefs.getString('loginResponse');
//     if (loginResponseString != null) {
//       Map<String, dynamic> loginResponseMap = jsonDecode(loginResponseString);
//       flag.value = loginResponseMap['flag'];
//     }
//   }
//     Future<Map<String, String?>> getEmpDetails() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? loginResponseString = prefs.getString('loginResponse');
//     if (loginResponseString != null) {
//       Map<String, dynamic> loginResponseMap = jsonDecode(loginResponseString);
//       String? empName = loginResponseMap['EmpName'];
//       String? empCode = loginResponseMap['EmpCode']?.toString().split('.')[0];
//       String flag = loginResponseMap['flag'];
//       return {'EmpName': empName, 'EmpCode': empCode.toString(), 'flag': flag};
//     }
//     return {'EmpName': null, 'EmpCode': null, 'flag': null};
//   }
class DashboardController extends GetxController {
  RxString selectedValue = ''.obs;
  RxString flag = "".obs;
  RxString addAccess = "".obs;

  @override
  void onInit() {
    super.onInit();
    loadSelectedValue();
    getEmpDetails();
  }

  Future<void> loadSelectedValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedValue = prefs.getString('selectedValue');
    if (savedValue != null) {
      selectedValue.value = savedValue;
      print ('saved value $savedValue');
    }
  }
  // Future<void> _getFlag() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? loginResponseString = prefs.getString('loginResponse');
  //   if (loginResponseString != null) {
  //     Map<String, dynamic> loginResponseMap = jsonDecode(loginResponseString);
  //     flag.value = loginResponseMap['flag'];
  //     addAccess.value = loginResponseMap['addAccess'];
  //   }

   
  // }
   Future<Map<String, String?>> getEmpDetails() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? loginResponseString = prefs.getString('loginResponse');
      if (loginResponseString != null) {
        Map<String, dynamic> loginResponseMap = jsonDecode(loginResponseString);
        String? empName = loginResponseMap['EmpName'];
        String? empCode = loginResponseMap['EmpCode']?.toString().split('.')[0];
        String flag = loginResponseMap['flag'];
        String addAccess = loginResponseMap['addAccess'];
        return {
          'EmpName': empName,
          'EmpCode': empCode.toString(),
          'flag': flag,
          'addAccess':addAccess
        };
      }
      return {'EmpName': null, 'EmpCode': null, 'flag': null};
    }
}
