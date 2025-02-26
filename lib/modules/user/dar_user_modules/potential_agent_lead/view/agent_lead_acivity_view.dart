import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../shared/routes/app_routes.dart';
import '../../../../../shared/widget/app_loader.dart';
import '../controller/potential_agent_lead_controller.dart';

class AgentLeadActivityReport extends GetView<PotentialAgentLeadController> {
  @override
  final PotentialAgentLeadController controller =
      Get.put(PotentialAgentLeadController());
  AgentLeadActivityReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => controller.isSearching.value
            ? TextField(
                controller: controller.searchController,
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.white)
                ),
                autofocus: true,
                onChanged: (value) {
    controller.filterSearchResults(value);
  },
              )
            : const Text('Agent Lead Activity')),
        actions: [
          IconButton(
            onPressed: () {
              controller.isSearching.value = !controller.isSearching.value;
              if (!controller.isSearching.value) {
                controller.searchController.clear();
              }
            },
            icon: Obx(() => Icon(controller.isSearching.value ? Icons.close : Icons.search)),
          ),
          IconButton(
              onPressed: () async {
                await controller.getAgentLeadActivitytData();
                Get.toNamed(AppRoutes.addPotentialAgentLead);
              },
              icon: const Icon(Icons.add)),
        ],
        leading: BackButton(
          style: ButtonStyle(iconSize: WidgetStateProperty.all(20)),
          onPressed: () {
            if (kIsWeb) {
          Get.offNamed(AppRoutes.webdashboard);
        } else {
          Get.offNamed(AppRoutes.dashboard);
        }
          }

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
      itemCount: controller.filteredAgentLeadDetails.length,
      itemBuilder: (context, index) {
        return ExpansionTile(
          title: Row(
            children: [
              Text(
                controller.filteredAgentLeadDetails[index].typeOfActivity!,
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
                '${controller.filteredAgentLeadDetails[index].leadType} | ${controller.filteredAgentLeadDetails[index].vintage}',
                style: const TextStyle(
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
          subtitle: Text(
            '${DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.filteredAgentLeadDetails[index].dateOfVisit!.toString()))} | ${controller.filteredAgentLeadDetails[index].zone}',
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
                            label: Text(controller
                                .filteredAgentLeadDetails[index].executive!)),
                      ],
                      rows: [
                        DataRow(cells: [
                          const DataCell(Text('Team Leader')),
                          DataCell(Text(controller
                              .filteredAgentLeadDetails[index].teamLeader!
                              .split('.')[0])),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('Date Of LeadInput')),
                          DataCell(Text(DateFormat('yyyy-MM-dd').format(
                              DateTime.parse(controller
                                  .filteredAgentLeadDetails[index].dateOfVisit
                                  .toString())))),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('Type of Activity')),
                          DataCell(Text(controller
                              .filteredAgentLeadDetails[index]
                              .typeOfActivity!)),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('Potential Permium Per Month')),
                          DataCell(Text(controller
                              .filteredAgentLeadDetails[index].premiumCollected
                              .toString())),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('Agent Name')),
                          DataCell(Text(controller
                              .filteredAgentLeadDetails[index].toWhomMeet!)),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('Agent Contact No.')),
                          DataCell(Text(controller
                              .filteredAgentLeadDetails[index]
                              .toWhomMeetNumber!)),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('Email')),
                          DataCell(Text(controller
                              .filteredAgentLeadDetails[index].email!)),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('Agent Location')),
                          DataCell(Text(controller
                              .filteredAgentLeadDetails[index].location!)),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('Competition Informatiom')),
                          DataCell(Text(controller
                              .filteredAgentLeadDetails[index]
                              .competitionInfo!)),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('Remark ')),
                          DataCell(Text(controller
                              .filteredAgentLeadDetails[index]
                              .remarkComments!)),
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
