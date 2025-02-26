import 'package:dsr_clone/modules/manger/dar_manager_modules/potential_agent_lead/controller/manager_agentlead_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../shared/widget/app_loader.dart';

class ManagerAgentLeadActivityReport
    extends GetView<ManagerAgentLeadController> {
  @override
  final ManagerAgentLeadController controller = Get.put(ManagerAgentLeadController());
  ManagerAgentLeadActivityReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agent Lead Activity'),
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
      itemCount: controller.agntLead.length,
      itemBuilder: (context, index) {
        return ExpansionTile(
          title: Row(
            children: [
              Text(
                controller.agntLead[index].typeOfActivity!,
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
                '${controller.agntLead[index].leadType} | ${controller.agntLead[index].vintage}',
                style: const TextStyle(
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
          subtitle: Text(
            '${DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.agntLead[index].dateOfVisit!.toString()))} | ${controller.agntLead[index].zone}',
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
                            label: Text(controller.agntLead[index].executive!)),
                      ],
                      rows: [
                        DataRow(cells: [
                          const DataCell(Text('Team Leader')),
                          DataCell(Text(controller.agntLead[index].teamLeader!
                              .split('.')[0])),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('Date Of LeadInput')),
                          DataCell(Text(DateFormat('yyyy-MM-dd').format(
                              DateTime.parse(controller
                                  .agntLead[index].dateOfVisit
                                  .toString())))),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('Type of Activity')),
                          DataCell(
                              Text(controller.agntLead[index].typeOfActivity!)),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('Potential Permium Per Month')),
                          DataCell(Text(controller
                              .agntLead[index].premiumCollected
                              .toString())),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('Agent Name')),
                          DataCell(
                              Text(controller.agntLead[index].toWhomMeet!)),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('Agent Contact No.')),
                          DataCell(Text(
                              controller.agntLead[index].toWhomMeetNumber!)),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('Email')),
                          DataCell(Text(controller.agntLead[index].email!)),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('Agent Location')),
                          DataCell(Text(controller.agntLead[index].location!)),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('Competition Informatiom')),
                          DataCell(Text(
                              controller.agntLead[index].competitionInfo!)),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('Remark ')),
                          DataCell(
                              Text(controller.agntLead[index].remarkComments!)),
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
