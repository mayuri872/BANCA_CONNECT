import 'dart:convert';

import 'package:dsr_clone/shared/routes/app_routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../shared/widget/app_loader.dart';
import '../controller/dar_activity_controller.dart';

class DarActivityReport extends GetView<DarActivityController> {
  @override
  final DarActivityController controller = Get.put(DarActivityController());
  DarActivityReport({super.key});

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
            : const Text('Daily Activity Report')),
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
              onPressed: () async {
                await controller.getDailyActivityReportData();
                Get.toNamed(AppRoutes.darActivity);
              },
              icon: const Icon(Icons.add))
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
      itemCount: controller.filteredActivityDetails.length,
      itemBuilder: (context, index) {
        return ExpansionTile(
          title: Text(
            controller.filteredActivityDetails[index].typeOfActivity!,
            style: const TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
          ),
          subtitle: Text(
            '${controller.filteredActivityDetails[index].dateOfVisit != null ? DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.filteredActivityDetails[index].dateOfVisit!.toString())) : 'No Date'} | ${controller.filteredActivityDetails[index].zone}',
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
                                .filteredActivityDetails[index].executive!)),
                      ],
                      rows: [
                        DataRow(cells: [
                          const DataCell(Text('Team Leader')),
                          DataCell(Text(controller
                              .filteredActivityDetails[index].teamLeader!
                              .split('.')[0])),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('Date Of Visit')),
                          DataCell(Text(DateFormat('yyyy-MM-dd').format(
                              DateTime.parse(controller
                                  .filteredActivityDetails[index].dateOfVisit!
                                  .toString()))))
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('Type Of Activity')),
                          DataCell(Text(controller
                              .filteredActivityDetails[index].typeOfActivity!)),
                        ]),
                        const DataRow(cells: [
                          DataCell(Text('Sub Category')),
                          DataCell(Text('')),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('Agent Referred Name')),
                          DataCell(Text(controller
                              .filteredActivityDetails[index].agentName!)),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('Sub Type Of Activity')),
                          DataCell(
                            Text(
                              () {
                                try {
                                  String jsonString = controller
                                      .filteredActivityDetails[index]
                                      .responceSubTypeOfActivity!;
                                  var decodedJson = jsonDecode(jsonString);

                                  if (decodedJson is List) {
                                    if (decodedJson.isNotEmpty) {
                                      var firstElement = decodedJson[0];
                                      return firstElement[
                                              'subTypeOfActivity'] ??
                                          'N/A';
                                    } else {
                                      return 'No subTypeOfActivity';
                                    }
                                  } else if (decodedJson is Map) {
                                    return decodedJson['subTypeOfActivity'] ??
                                        'N/A';
                                  } else {
                                    return 'Unexpected JSON format';
                                  }
                                } catch (e) {
                                  return 'Invalid JSON';
                                }
                              }(),
                            ),
                          ),
                        ]),
                        DataRow(cells: [
                          const DataCell(
                              Text('Premium Collected Including GSt%')),
                          DataCell(
                            Text(
                              () {
                                try {
                                  String jsonString = controller
                                      .filteredActivityDetails[index]
                                      .responceSubTypeOfActivity!;
                                  var decodedJson = jsonDecode(jsonString);

                                  if (decodedJson is List) {
                                    if (decodedJson.isNotEmpty) {
                                      var firstElement = decodedJson[0];
                                      return firstElement[
                                              'premium_Collected'] ??
                                          'N/A';
                                    } else {
                                      return 'No subTypeOfActivity';
                                    }
                                  } else if (decodedJson is Map) {
                                    return decodedJson['premium_Collected'] ??
                                        'N/A';
                                  } else {
                                    return 'Unexpected JSON format';
                                  }
                                } catch (e) {
                                  return 'Invalid JSON';
                                }
                              }(),
                            ),
                          )
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('Reporting Manager')),
                          DataCell(Text(controller
                              .filteredActivityDetails[index]
                              .reportingManager!)),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('Email')),
                          DataCell(Text(controller
                              .filteredActivityDetails[index].email!)),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('Agent Name')),
                          DataCell(Text(controller
                              .filteredActivityDetails[index].agentName!)),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('Agent Contact No.')),
                          DataCell(Text(controller
                              .filteredActivityDetails[index]
                              .toWhomMeetNumber!)),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('Meet Location')),
                          DataCell(Text(controller
                              .filteredActivityDetails[index].location!)),
                        ]),
                        const DataRow(cells: [
                          DataCell(Text('Client/Customer Name')),
                          DataCell(Text('')),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('Remark')),
                          DataCell(Text(controller
                              .filteredActivityDetails[index].remarkComments!)),
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
