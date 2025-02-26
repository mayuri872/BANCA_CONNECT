
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../shared/widget/app_loader.dart';
import '../controller/manager_custlead_controller.dart';

class ManagerCustLeadActivityReport
    extends GetView<ManagerCustLeadController> {
  @override
  final ManagerCustLeadController controller = Get.put(ManagerCustLeadController());
  ManagerCustLeadActivityReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Lead Activity'),
        leading: BackButton(
          style: ButtonStyle(iconSize: WidgetStateProperty.all(20)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
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
      itemCount: controller.custLead.length,
      itemBuilder: (context, index) {
        return ExpansionTile(
          title: Row(
            children: [
              Text(
                controller.custLead[index].typeOfActivity!,
                style: const TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                width: 5.0,
              ),
              Text(
                '${controller.custLead[index].leadType} | ${controller.custLead[index].vintage}',
                style: const TextStyle(
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
          subtitle: Text(
            '${DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.custLead[index].dateOfVisit!.toString()))} | ${controller.custLead[index].zone}',
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
                        DataColumn(
                            label: Text(controller.custLead[index].executive!)),
                      ],
                      rows: [
                        DataRow(cells: [
                          const DataCell(Text('Team Leader')),
                          DataCell(Text(controller.custLead[index].teamLeader!
                              .split('.')[0])),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('Date Of LeadInput')),
                          DataCell(Text(DateFormat('yyyy-MM-dd').format(
                              DateTime.parse(controller
                                  .custLead[index].dateOfVisit
                                  .toString())))),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('Type of Activity')),
                          DataCell(
                              Text(controller.custLead[index].typeOfActivity!)),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('Potential Permium Per Month')),
                          DataCell(Text(controller
                              .custLead[index].premiumCollected
                              .toString())),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('Agent Name')),
                          DataCell(
                              Text(controller.custLead[index].toWhomMeet!)),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('Agent Contact No.')),
                          DataCell(Text(
                              controller.custLead[index].toWhomMeetNumber!)),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('Email')),
                          DataCell(Text(controller.custLead[index].email!)),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('Agent Location')),
                          DataCell(Text(controller.custLead[index].location!)),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('Competition Informatiom')),
                          DataCell(Text(
                              controller.custLead[index].competitionInfo!)),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('Remark ')),
                          DataCell(
                              Text(controller.custLead[index].remarkComments!)),
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
