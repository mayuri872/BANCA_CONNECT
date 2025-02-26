// ignore_for_file: deprecated_member_use

import 'package:dsr_clone/modules/dashboard/controller/dashboard_controller.dart';
import 'package:dsr_clone/shared/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/routes/app_routes.dart';
import '../../../shared/widget/exit_app_pop_up.dart';

class WebDashboardView extends GetView<DashboardController> {
  const WebDashboardView({super.key});

  @override

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await exitApp(context);
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.body,
        body: Row(
          children: <Widget>[
            Container(
              width: 350,
              child: Drawer(
                width: MediaQuery.of(context).size.width * 0.7,
                backgroundColor: AppColors.white2,
                child: FutureBuilder<Map<String, String?>>(
                  future: controller.getEmpDetails(),
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
                              Get.offAllNamed(AppRoutes.webdashboard);
                            },
                          ),
                          if (empDetails['flag'] == '1')
                            ListTile(
                              leading: const Icon(Icons.library_books, size: 20.0),
                              title: const Text('Daily Activity Report',
                                  style: TextStyle(fontSize: 15.0,)),
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
                                Get.offAllNamed(AppRoutes.managerDashboard);
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
                              title:
                              const Text('Potential Agent Lead', style: TextStyle(fontSize: 15.0)),
                              onTap: () {
                                Get.offAllNamed(AppRoutes.managerAgentLead);
                              },
                            ),
                          if (empDetails['flag'] == '2' || empDetails['flag'] == '4')
                            ListTile(
                              leading: const Icon(Icons.file_copy, size: 20.0),
                              title:const Text('Potential Customer Lead', style: TextStyle(fontSize: 15.0)),
                              onTap: () {
                                Get.offAllNamed(AppRoutes.managerCustLeadReport);
                              },
                            ),
                          if (empDetails['flag'] == '2' || empDetails['flag'] == '4')
                            ListTile(
                              leading: const Icon(Icons.file_copy, size: 20.0),
                              title: const Text('Leads Report', style: TextStyle(fontSize: 15.0)),
                              onTap: () {
                                Get.offAllNamed(AppRoutes.managerleadReports);
                              },
                            ),
                          const Divider(),
                          ListTile(
                            title:const Text('Log out', style: TextStyle(fontSize: 15.0)),
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
              ),
            ),
             Expanded(
  child: SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Obx(() => buildSections(context, controller.flag.value)),
    ),
  ),
),
          ],
        ),
      ),
    );
  }
}

Widget buildSections(BuildContext context, String flag) {
  if (flag == '1') {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: buildSection(context, "DAR Activity", AppRoutes.darActivityReport)),
            Expanded(child: buildSection(context, "Potential Agent Lead", AppRoutes.potentialAgentLeadReport)),
          ],
        ),
        Row(
          children: [
            Expanded(child: buildSection(context, "Potential Customer Lead", AppRoutes.customerLeadActivityReport)),
            Expanded(child: Container()), // Empty container to fill the space
          ],
        ),
      ],
    );
  } else if (flag == '2' || flag == '4') {
    return Column(
          
      children: [
        Row(
          children: [
            Expanded(child: buildSection(context, "Dashboard", AppRoutes.managerDashboard)),
            Expanded(child: buildSection(context, "Team Activity", AppRoutes.teams)),
          ],
        ),
        Row(
          children: [
            Expanded(child: buildSection(context, "Reports", AppRoutes.reports)),
            Expanded(child: buildSection(context, "Potential Agent Lead", AppRoutes.managerAgentLead)),
          ],
        ),
        Row(
          children: [
            Expanded(child: buildSection(context, "Potential Customer Lead", AppRoutes.managerCustLeadReport)),
            Expanded(child: buildSection(context, "Leads Report", AppRoutes.managerleadReports)),
          ],
        ),
      ],
    );
  } else {
    return Container();
  }
}

  Widget buildSection(BuildContext context, String title, String route ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: sections(context, title, route),
    );
  }


Widget sections(BuildContext context, String title, String route) {
  return Row(
    children: [
      Expanded(
        child: InkWell(
          onTap: () {
            Get.toNamed(route);
          },
          child: Container(
            height: 100,
            width: MediaQuery.of(context).size.width * 0.6,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  blurRadius: 10,
                  color: AppColors.black50,
                  offset: Offset(1, 3),
                ),
              ],
              color: AppColors.white,
              image: const DecorationImage(
                image: AssetImage('assets/w2.jpg'),
                fit: BoxFit.fill,
                opacity: 0.4,
              ),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: AppColors.white,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w900,
                    color: AppColors.fontColor50,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}