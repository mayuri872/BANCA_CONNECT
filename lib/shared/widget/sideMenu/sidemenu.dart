import 'package:dsr_clone/shared/style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../routes/app_routes.dart';
import 'dart:convert';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  RxString selectedValue = ''.obs;

  @override
  void initState() {
    super.initState();
    loadSelectedValue();
  }

  Future<void> loadSelectedValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedValue = prefs.getString('selectedValue');
    if (savedValue != null) {
      selectedValue.value = savedValue;
      print('saved value $savedValue');
    }
  }

  Future<Map<String, String?>> getEmpDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? loginResponseString = prefs.getString('loginResponse');
    if (loginResponseString != null) {
      Map<String, dynamic> loginResponseMap = jsonDecode(loginResponseString);
      String? empName = loginResponseMap['EmpName'];
      String? empCode = loginResponseMap['EmpCode']?.toString().split('.')[0];
      String flag = loginResponseMap['flag'];
      return {'EmpName': empName, 'EmpCode': empCode.toString(), 'flag': flag};
    }
    return {'EmpName': null, 'EmpCode': null, 'flag': null};
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.7,
      backgroundColor: AppColors.white2,
      child: FutureBuilder<Map<String, String?>>(
        future: getEmpDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading data'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No data found'));
          } else {
            Map<String, String?> empDetails = snapshot.data!;
            return ListView(
              padding: EdgeInsets.zero,
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(
                    empDetails['EmpName'] ?? 'No EmpName found',
                    style: const TextStyle(fontSize: 15.0),
                  ),
                  accountEmail: Text(
                    empDetails['EmpCode'] ?? 'No EmpCode found',
                    style: const TextStyle(fontSize: 15.0),
                  ),
                  currentAccountPicture: const CircleAvatar(
                    radius: 10.0,
                    child: Icon(Icons.person_3_sharp),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.home, size: 20.0),
                  title: const Text('Home', style: TextStyle(fontSize: 15.0)),
                  onTap: () {
                    Get.offAllNamed(AppRoutes.dashboard);
                  },
                ),
                if (empDetails['flag'] == '1')
                  ListTile(
                    leading: const Icon(Icons.library_books, size: 20.0),
                    title: const Text('Daily Activity Report',
                        style: TextStyle(fontSize: 15.0)),
                    onTap: () {
                      Get.offAllNamed(AppRoutes.darActivityReport);
                    },
                  ),
                if (empDetails['flag'] == '1')
                  ListTile(
                    leading: const Icon(Icons.library_books, size: 20.0),
                    title: const Text('Agent Lead Activity Report',
                        style: TextStyle(fontSize: 15.0)),
                    onTap: () {
                      Get.offAllNamed(AppRoutes.potentialAgentLeadReport);
                    },
                  ),
                if (empDetails['flag'] == '1')
                  ListTile(
                    leading: const Icon(Icons.library_books, size: 20.0),
                    title: const Text('Customer Lead Activity Report',
                        style: TextStyle(fontSize: 15.0)),
                    onTap: () {
                      Get.offAllNamed(AppRoutes.customerLeadActivityReport);
                    },
                  ),
                if (empDetails['flag'] == '2' || empDetails['flag'] == '4')
                  ListTile(
                    leading: const Icon(Icons.dashboard, size: 20.0),
                    title: const Text('Dashboard',
                        style: TextStyle(fontSize: 15.0)),
                    onTap: () {
                      if(selectedValue.value == 'Banca Connect'){
                        Get.offAllNamed(AppRoutes.dsrManagerDashboardReport);
                      }
                      else{
                        Get.offAllNamed(AppRoutes.managerDashboard);
                      }
                      
                    },
                  ),
                if (empDetails['flag'] == '2' || empDetails['flag'] == '4')
                  ListTile(
                    leading: const Icon(Icons.account_circle_sharp, size: 20.0),
                    title: const Text('Team Activity',
                        style: TextStyle(fontSize: 15.0)),
                    onTap: () {
                      Get.offAllNamed(AppRoutes.teams);
                    },
                  ),
                if (empDetails['flag'] == '2' || empDetails['flag'] == '4')
                  ListTile(
                    leading: const Icon(Icons.file_copy, size: 20.0),
                    title: const Text('Reports', style: TextStyle(fontSize: 15.0)),
                    onTap: () {
                      Get.offAllNamed(AppRoutes.reports);
                    },
                  ),
                if (empDetails['flag'] == '2' || empDetails['flag'] == '4')
                  ListTile(
                    leading: const Icon(Icons.file_copy, size: 20.0),
                    title: const Text('Potential Agent Lead',
                        style: TextStyle(fontSize: 15.0)),
                    onTap: () {
                      Get.offAllNamed(AppRoutes.managerAgentLead);
                    },
                  ),
                if (empDetails['flag'] == '2' || empDetails['flag'] == '4')
                  ListTile(
                    leading: const Icon(Icons.file_copy, size: 20.0),
                    title: const Text('Potential Customer Lead',
                        style: TextStyle(fontSize: 15.0)),
                    onTap: () {
                      Get.offAllNamed(AppRoutes.managerCustLeadReport);
                    },
                  ),
                if (empDetails['flag'] == '2' || empDetails['flag'] == '4')
                  ListTile(
                    leading: const Icon(Icons.file_copy, size: 20.0),
                    title: const Text('Leads Report',
                        style: TextStyle(fontSize: 15.0)),
                    onTap: () {
                      Get.offAllNamed(AppRoutes.managerleadReports);
                    },
                  ),
                const Divider(),
                ListTile(
                  title: const Text('Log out', style: TextStyle(fontSize: 15.0)),
                  leading: const Icon(Icons.power_settings_new, size: 20.0),
                  onTap: () {
                    Get.offAllNamed(AppRoutes.login);
                  },
                ),
              ],
            );
          }
        },
      ),
    );
  }
}