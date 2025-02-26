

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../shared/widget/app_loader.dart';
import '../../../../../../shared/widget/sideMenu/sidemenu.dart';
import '../controller/dsr_activity_controller.dart';

class DsrActivityView extends GetView<DsrActivityController> {
  @override
  final DsrActivityController controller = Get.put(DsrActivityController());
  DsrActivityView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getDailyActivityReportDataDSR();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Activity Report'),
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
      itemCount: controller.responceDSRAcitvityDetails.length,
      itemBuilder: (context, index) {
        return ExpansionTile(
          title: Text(
            controller.responceDSRAcitvityDetails[index].typeOfActivity!,
            style: const TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
          ),
          subtitle: Text(
            '${controller.responceDSRAcitvityDetails[index].dateOfVisit} | ${controller.responceDSRAcitvityDetails[index].zone}',
            style: const TextStyle(fontSize: 14.0, color: Colors.grey),
          ),
          children: <Widget>[
            SizedBox(
              width: 800.0,
              child: Card(
                child: Column(
                  children: <Widget>[
                    DataTable(
                      columns: [
                        const DataColumn(label: Text('Executive')),
                        DataColumn(label: Text(controller.responceDSRAcitvityDetails[index].executive!)),
                      ],
                      rows: [
                        DataRow(cells: [
                          const DataCell(Text('Team Leader')),
                          DataCell(Text(controller.responceDSRAcitvityDetails[index].teamLeader!)),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('Date Of Visit')),
                          DataCell(Text(controller.responceDSRAcitvityDetails[index].dateOfVisit.toString())),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('Start Time')),
                          DataCell(Text(controller.responceDSRAcitvityDetails[index].startTime!)),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('End Time')),
                          DataCell(Text(controller.responceDSRAcitvityDetails[index].endTime!)),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('Duration')),
                          DataCell(Text(controller.responceDSRAcitvityDetails[index].duration!)),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('Type Of Activity')),
                          DataCell(Text(controller.responceDSRAcitvityDetails[index].typeOfActivity!)),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('Bank Name')),
                          DataCell(Text(controller.responceDSRAcitvityDetails[index].bankName!)),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('Branch Code')),
                          DataCell(Text(controller.responceDSRAcitvityDetails[index].branchCode!)),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('Bank Branch Name')),
                          DataCell(Text(controller.responceDSRAcitvityDetails[index].bankBranchName!)),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('Person Meet')),
                          DataCell(Text(controller.responceDSRAcitvityDetails[index].toWhomMeet!)),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('Person Meet Number')),
                          DataCell(Text(controller.responceDSRAcitvityDetails[index].toWhomMeetNumber!)),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('Remark Comments')),
                          DataCell(Text(controller.responceDSRAcitvityDetails[index].remarkComments!)),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('Premium Collected')),
                          DataCell(Text(controller.responceDSRAcitvityDetails[index].premiumCollected.toString())),
                        ]),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}