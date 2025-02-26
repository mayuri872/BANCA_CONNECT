import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../shared/routes/app_routes.dart';
import '../../../../../shared/widget/app_loader.dart';
import '../controller/customer_lead_controller.dart';

class CustomerLeadActivityReport extends GetView<CustomerLeadController> {
  @override
  final CustomerLeadController controller = Get.put(CustomerLeadController());
  CustomerLeadActivityReport({super.key});

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
                    hintStyle: TextStyle(color: Colors.white)),
                autofocus: true,
                onChanged: (value) {
                  controller.filterSearchResults(value);
                },
              )
            : const Text('Customer Lead Activity')),
        actions: [
          IconButton(
            onPressed: () {
              controller.isSearching.value = !controller.isSearching.value;
              if (!controller.isSearching.value) {
                controller.searchController.clear();
              }
            },
            icon: Obx(() => Icon(
                controller.isSearching.value ? Icons.close : Icons.search)),
          ),
          IconButton(
              onPressed: () {
            if (kIsWeb) {
          Get.offNamed(AppRoutes.webdashboard);
        } else {
          Get.offNamed(AppRoutes.dashboard);
        }
          },

              icon: const Icon(Icons.add))
        ],
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
      itemCount: controller.responceAgentLeadDetails.length,
      itemBuilder: (context, index) {
        return ExpansionTile(
          title: Row(
            children: [
              Text(
                controller.responceAgentLeadDetails[index].typeOfActivity!,
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
                '${controller.responceAgentLeadDetails[index].leadType} | ${controller.responceAgentLeadDetails[index].vintage}',
                style: const TextStyle(
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
          subtitle: Text(
            '${DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.responceAgentLeadDetails[index].dateOfVisit!.toString()))} | ${controller.responceAgentLeadDetails[index].zone}',
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
                                .responceAgentLeadDetails[index].executive!)),
                      ],
                      rows: [
                        DataRow(cells: [
                          const DataCell(Text('Team Leader')),
                          DataCell(Text(controller
                              .responceAgentLeadDetails[index].teamLeader!
                              .split('.')[0])),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('Date Of Lead Input')),
                          DataCell(Text(DateFormat('yyyy-MM-dd').format(
                              DateTime.parse(controller
                                  .responceAgentLeadDetails[index].dateOfVisit
                                  .toString())))),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('Type of Activity')),
                          DataCell(Text(controller
                              .responceAgentLeadDetails[index]
                              .typeOfActivity!)),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('Potential Permium Per Month')),
                          DataCell(Text(controller
                              .responceAgentLeadDetails[index].premiumCollected
                              .toString())),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('Agent Name')),
                          DataCell(Text(controller
                              .responceAgentLeadDetails[index].toWhomMeet!)),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('Agent Contact No.')),
                          DataCell(Text(controller
                              .responceAgentLeadDetails[index]
                              .toWhomMeetNumber!)),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('Email')),
                          DataCell(Text(controller
                              .responceAgentLeadDetails[index].email!)),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('Agent Location')),
                          DataCell(Text(controller
                              .responceAgentLeadDetails[index].location!)),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('Competition Informatiom')),
                          DataCell(Text(controller
                              .responceAgentLeadDetails[index]
                              .competitionInfo!)),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('Remark ')),
                          DataCell(Text(controller
                              .responceAgentLeadDetails[index]
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
