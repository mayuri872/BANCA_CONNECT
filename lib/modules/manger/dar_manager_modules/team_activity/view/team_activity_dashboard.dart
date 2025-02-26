import 'package:dsr_clone/shared/style/app_colors.dart';
import 'package:dsr_clone/shared/widget/sideMenu/sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../shared/widget/app_loader.dart';
import '../controller/teams_controller.dart';

class TeamActivityDashboard extends GetView<TeamsController> {
  TeamActivityDashboard({super.key});
  final TeamsController controllerTeams = Get.put(TeamsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.body,
      appBar: AppBar(title: const Text('Teams Activity Dashboard')),
      drawer: const SideMenu(),
      body: Obx(() {
        return (controllerTeams.isDataLoaded.value)
            ? pageBody(context)
            : AppLoader.onScreenLoaderWithScaffold();
      }),
    );
  }

  Widget pageBody(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: controller.responceMangerDashDetails.length,
      itemBuilder: (context, index) {
        return Card(
          child: Column(
            children: <Widget>[
              Obx(() {
                return DataTable(
                  headingTextStyle: const TextStyle(fontSize: 10.0),
                  dataTextStyle: const TextStyle(fontSize: 10.0),
                  columns: [
                    const DataColumn(label: Text('Activities')),
                    DataColumn(label: Text(DateFormat('MMM d\nyyyy').format(controller.yesterdayDate))),
                    DataColumn(label: Text('Current month\ntill ${DateFormat('MMM d, yyyy').format(controller.yesterdayDate)}')),
                  ],
                  rows: [
                    DataRow(cells: [
                      const DataCell(Text('Recruitment')),
                      DataCell(Text(controller.yesterdayRecruitmentCount.toString())),
                      DataCell(Text(controller.lastMonthRecruitmentCount.toString())),
                    ]),
                    DataRow(cells: [
                      const DataCell(Text('Sales')),
                      DataCell(Text(controller.yesterdaySalesCount.toString())),
                      DataCell(Text(controller.lastMonthSalesCount.toString())),
                    ]),
                    DataRow(cells: [
                      const DataCell(Text('Total', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataCell(Text(
                        (controller.yesterdayRecruitmentCount.value + controller.yesterdaySalesCount.value).toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )),
                      DataCell(Text(
                        (controller.lastMonthRecruitmentCount.value + controller.lastMonthSalesCount.value).toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )),
                    ]),
                  ],
                );
              }),
            ],
          ),
        );
      },
    );
  }
}
