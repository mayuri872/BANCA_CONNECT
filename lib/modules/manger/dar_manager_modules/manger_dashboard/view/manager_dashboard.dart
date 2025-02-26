import 'package:dsr_clone/shared/routes/app_routes.dart';
import 'package:dsr_clone/shared/widget/sideMenu/sidemenu.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../shared/widget/app_loader.dart';
import '../controller/manager_dashboard_controller.dart';

class ManagerDashboardView extends GetView<ManagerDashboardController> {
  @override
  final ManagerDashboardController controller = Get.put(ManagerDashboardController());
  ManagerDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        leading: BackButton(
          style: ButtonStyle(iconSize: WidgetStateProperty.all(20)),
          onPressed: () {
            if (kIsWeb) {
          Get.offNamed(AppRoutes.webdashboard);
        } else {
          Get.offNamed(AppRoutes.dashboard);
        }
          }
        )
      ),
      drawer: const SideMenu(),
      body: Obx(() {
        return (controller.isDataLoaded.value)
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
        return ExpansionTile(
          title: Text(
            controller.responceMangerDashDetails[index].name!,
            style: const TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
          ),
          subtitle: Text(
            'Total DAR Count : ${controller.responceMangerDashDetails[index].count} | Total Premium : ${controller.responceMangerDashDetails[index].sum ?? '0'} ',
            style: const TextStyle(fontSize: 14.0, color: Colors.grey),
          ),
          onExpansionChanged: (bool expanded) {
            if (expanded) {
              String id = controller.responceMangerDashDetails[index].id.toString();
              controller.getLastMonthData(id);
              controller.getYesterdayData(id);
            }
          },
          children: <Widget>[
            Card(
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
            ),
          ],
        );
      },
    );
  }
}