import 'package:dsr_clone/modules/dashboard/controller/dashboard_controller.dart';
import 'package:dsr_clone/shared/style/app_colors.dart';
import 'package:dsr_clone/shared/widget/sideMenu/sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/routes/app_routes.dart';
import '../../../shared/widget/exit_app_pop_up.dart';
import '../../../shared/widget/responsive.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await exitApp(context);
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.body,
        appBar: AppBar(title: const Text('Dashboard')),
        drawer: Responsive.isDesktop(context) 
            ? null 
            : const SideMenu(),
        body: Responsive(
          mobile: buildMobileLayout(context),
          tablet: buildTabletLayout(context),
          desktop: buildDesktopLayout(context),
        ),
      ),
    );
  }

  Widget buildMobileLayout(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Obx(() => buildSections(context, controller.flag.value)),
          ],
        ),
      ),
    );
  }

  Widget buildTabletLayout(BuildContext context) {
    return buildMobileLayout(context); 
  }

  Widget buildDesktopLayout(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: const SideMenu(),
        ),
        Expanded(
          flex: 8,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Obx(() => buildSections(context, controller.flag.value)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildSections(BuildContext context, String flag) {
    if (flag == '1') {
      return Column(
        children: [
          if (controller.selectedValue.value == 'Banca Connect') ...[
          buildSection(context, "DSR Activity", AppRoutes.dsrActivity),
        ] else ...[
         buildSection(context, "DAR Activity", AppRoutes.darActivityReport),
          buildSection(context, "Potential Agent Lead", AppRoutes.potentialAgentLeadReport),
          buildSection(context, "Potential Customer Lead", AppRoutes.customerLeadActivityReport),
        ],
          
        
      ],
       
        
      );
    } else if (flag == '2' || flag == '4') {
      return Column(
        children: [
          if (controller.selectedValue.value == 'Banca Connect') ...[
          buildSection(context, "DSR Activity", AppRoutes.darActivityReport),
          buildSection(context, "Dashbaord", AppRoutes.dsrManagerDashboardReport),
          buildSection(context, "Team Activity", AppRoutes.customerLeadActivityReport),
          buildSection(context, "Reports", AppRoutes.customerLeadActivityReport),
        ] else ...[
          buildSection(context, "Dashboard", AppRoutes.managerDashboard),
          buildSection(context, "Team Activity", AppRoutes.teams),
          buildSection(context, "Reports", AppRoutes.reports),
          buildSection(context, "Potential Agent Lead", AppRoutes.managerAgentLead),
          buildSection(context, "Potential Customer Lead", AppRoutes.managerCustLeadReport),
          buildSection(context, "Leads Report", AppRoutes.managerleadReports),
        ],
      ],
      );
    } else {
      return Container();
    }
  }

  Widget buildSection(BuildContext context, String title, String route) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: sections(context, title, route),
    );
  }
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