import 'dart:convert';

import 'package:dsr_clone/modules/manger/dar_manager_modules/reports/controller/reports_controller.dart';
import 'package:dsr_clone/shared/style/app_colors.dart';
import 'package:dsr_clone/shared/widget/sideMenu/sidemenu.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../shared/routes/app_routes.dart';
import '../../../../../shared/style/app_input_decoration.dart';
import '../../../../../shared/widget/app_loader.dart';

class ReportsView extends GetView<ReportsController> {
  ReportsView({super.key});
  @override
  final ReportsController controller = Get.put(ReportsController());

  @override
Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.body,
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
            : const Text('Reports')),
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
      drawer: const SideMenu(),
      body: DefaultTabController(
        length: 4,
        child: Column(
          children: [
            TabBar(
              controller: controller.tabController,
              tabs: const [
                Tab(text: 'Manager'),
                Tab(text: 'Zone'),
                Tab(text: 'Activity'),
                Tab(text: 'Date'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: controller.tabController,
                children: [
                  managerTab(context, key: UniqueKey()),
                  zoneTab(context, key: UniqueKey()),
                  activityTab(context, key: UniqueKey()),
                  dateTab(context, key: UniqueKey()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget managerTab(BuildContext context, {Key? key}) {
    return Column(
      key: key,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            child: Obx(() {
              return InputDecorator(
                decoration: AppInputDecoration.inputDecorationFormWithBorder(
                  isFreeze: false,
                  labelText: 'Select Zone',
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    hint: const Text('Select Zone',
                        style: TextStyle(fontSize: 13.0)),
                    value: controller.zoneList
                            .contains(controller.selectZone.value)
                        ? controller.selectZone.value
                        : null,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    iconEnabledColor: AppColors.black,
                    isExpanded: true,
                    isDense: true,
                    onChanged: (value) {
                      if (value != null) {
                        controller.selectZone.value = value;
                      }
                    },
                    items: [
                      ...controller.zoneList.map((item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Row(
                            children: [
                              Obx(() {
                                return Checkbox(
                                  value: controller.selectedzone.contains(item),
                                  onChanged: (bool? value) {
                                    if (value != null) {
                                      if (value) {
                                        controller.selectedzone.add(item);
                                        controller.selectZone.value = item;
                                      } else {
                                        controller.selectedzone.remove(item);
                                        if (controller.selectZone.value ==
                                            item) {
                                          controller.selectZone.value = '';
                                        }
                                      }
                                    }
                                  },
                                );
                              }),
                              Text(item),
                            ],
                          ),
                        );
                      }),
                      DropdownMenuItem<String>(
                        enabled: false,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                controller.getLeadersWithZoneApiData();
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Close'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            child: Obx(() {
              return InputDecorator(
                decoration: AppInputDecoration.inputDecorationFormWithBorder(
                  isFreeze: false,
                  labelText: 'Select Manager',
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    hint: const Text('Select Manager',
                        style: TextStyle(fontSize: 13.0)),
                    value: controller.managerList
                            .contains(controller.selectManager.value)
                        ? controller.selectManager.value
                        : null,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    iconEnabledColor: AppColors.black,
                    isExpanded: true,
                    isDense: true,
                    onChanged: (value) {
                      if (value != null) {
                        controller.selectManager.value = value;
                      }
                    },
                    items: [
                      ...controller.managerList.map((item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Row(
                            children: [
                              Obx(() {
                                return Checkbox(
                                  value: controller.selectedManagers
                                      .contains(item),
                                  onChanged: (bool? value) {
                                    if (value != null) {
                                      if (value) {
                                        controller.selectedManagers.add(item);
                                        controller.selectManager.value = item;
                                      } else {
                                        controller.selectedManagers
                                            .remove(item);
                                        if (controller.selectManager.value ==
                                            item) {
                                          controller.selectManager.value = '';
                                        }
                                      }
                                    }
                                  },
                                );
                              }),
                              Text(item),
                            ],
                          ),
                        );
                      }),
                      DropdownMenuItem<String>(
                        enabled: false,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                List<String> selectedManagerIds = controller
                                    .managerList
                                    .asMap()
                                    .entries
                                    .where((entry) => controller
                                        .selectedManagers
                                        .contains(entry.value))
                                    .map((entry) =>
                                        controller.managerIdList[entry.key])
                                    .toList();
                                controller.isDataLoaded.value = false;
                                controller
                                    .zoneManagerfiltersData(selectedManagerIds)
                                    .then((_) {
                                  controller.isDataLoaded.value = true;
                                });
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Close'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
        Expanded(
          child: Obx(() {
            return controller.isDataLoaded.value
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.zoneManagerfilters.length,
                    itemBuilder: (context, index) {
                      return ExpansionTile(
                        title: Text(
                          controller.zoneManagerfilters[index]
                              .typeOfActivity!,
                          style: const TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                        subtitle: Text(
                          '${controller.zoneManagerfilters[index].dateOfVisit != null ? DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.zoneManagerfilters[index].dateOfVisit!.toString())) : 'No Date'} | ${controller.zoneManagerfilters[index].zone}',
                          style: const TextStyle(
                              fontSize: 14.0, color: Colors.grey),
                        ),
                        children: <Widget>[
                          SizedBox(
                            width: 800.0,
                            child: Card(
                              child: Column(
                                children: <Widget>[
                                  DataTable(
                                    columns: [
                                      const DataColumn(
                                          label: Text('Executive')),
                                      DataColumn(
                                          label: Text(controller
                                              .zoneManagerfilters[index]
                                              .executive!)),
                                    ],
                                    rows: [
                                      DataRow(cells: [
                                        const DataCell(Text('Team Leader')),
                                        DataCell(Text(controller
                                            .zoneManagerfilters[index]
                                            .teamLeader!
                                            .split('.')[0])),
                                      ]),
                                      DataRow(cells: [
                                        const DataCell(Text('Date Of Visit')),
                                        DataCell(Text(DateFormat('yyyy-MM-dd')
                                            .format(DateTime.parse(controller
                                                .zoneManagerfilters[
                                                    index]
                                                .dateOfVisit!
                                                .toString()))))
                                      ]),
                                      DataRow(cells: [
                                        const DataCell(
                                            Text('Type Of Activity')),
                                        DataCell(Text(controller
                                            .zoneManagerfilters[index]
                                            .typeOfActivity!)),
                                      ]),
                                      const DataRow(cells: [
                                        DataCell(Text('Sub Category')),
                                        DataCell(Text('')),
                                      ]),
                                      DataRow(cells: [
                                        const DataCell(
                                            Text('Agent Referred Name')),
                                        DataCell(Text(controller
                                            .zoneManagerfilters[index]
                                            .agentName!)),
                                      ]),
                                      DataRow(cells: [
                                        const DataCell(
                                            Text('Sub Type Of Activity')),
                                        DataCell(
                                          Text(
                                            () {
                                              try {
                                                String jsonString = controller
                                                    .zoneManagerfilters[
                                                        index]
                                                    .responceSubTypeOfActivity!;
                                                var decodedJson =
                                                    jsonDecode(jsonString);

                                                if (decodedJson is List) {
                                                  if (decodedJson.isNotEmpty) {
                                                    var firstElement =
                                                        decodedJson[0];
                                                    return firstElement[
                                                            'subTypeOfActivity'] ??
                                                        'N/A';
                                                  } else {
                                                    return 'No subTypeOfActivity';
                                                  }
                                                } else if (decodedJson is Map) {
                                                  return decodedJson[
                                                          'subTypeOfActivity'] ??
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
                                        const DataCell(Text(
                                            'Premium Collected Including GSt%')),
                                        DataCell(
                                          Text(
                                            () {
                                              try {
                                                String jsonString = controller
                                                    .zoneManagerfilters[
                                                        index]
                                                    .responceSubTypeOfActivity!;
                                                var decodedJson =
                                                    jsonDecode(jsonString);

                                                if (decodedJson is List) {
                                                  if (decodedJson.isNotEmpty) {
                                                    var firstElement =
                                                        decodedJson[0];
                                                    return firstElement[
                                                            'premium_Collected'] ??
                                                        'N/A';
                                                  } else {
                                                    return 'No subTypeOfActivity';
                                                  }
                                                } else if (decodedJson is Map) {
                                                  return decodedJson[
                                                          'premium_Collected'] ??
                                                      'N/A';
                                                } else {
                                                  return 'Unexpected JSON format';
                                                }
                                              } catch (e) {
                                                // Print the error to debug
                                                return 'Invalid JSON';
                                              }
                                            }(),
                                          ),
                                        )
                                      ]),
                                      DataRow(cells: [
                                        const DataCell(Text('Email')),
                                        DataCell(Text(controller
                                            .zoneManagerfilters[index]
                                            .email!)),
                                      ]),
                                      DataRow(cells: [
                                        const DataCell(Text('Agent Name')),
                                        DataCell(Text(controller
                                            .zoneManagerfilters[index]
                                            .agentName!)),
                                      ]),
                                      DataRow(cells: [
                                        const DataCell(
                                            Text('Agent Contact No.')),
                                        DataCell(Text(controller
                                            .zoneManagerfilters[index]
                                            .toWhomMeetNumber!)),
                                      ]),
                                      DataRow(cells: [
                                        const DataCell(Text('Meet Location')),
                                        DataCell(Text(controller
                                            .zoneManagerfilters[index]
                                            .location!)),
                                      ]),
                                      const DataRow(cells: [
                                        DataCell(Text('Client/Customer Name')),
                                        DataCell(Text('')),
                                      ]),
                                      DataRow(cells: [
                                        const DataCell(Text('Remark')),
                                        DataCell(Text(controller
                                            .zoneManagerfilters[index]
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
                  )
                : AppLoader.onScreenLoaderWithScaffold();
          }),
        ),
      ],
    );
  }

  Widget zoneTab(BuildContext context, {Key? key}) {
    return Column(
      key: key,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            child: Obx(() {
              return InputDecorator(
                decoration: AppInputDecoration.inputDecorationFormWithBorder(
                  isFreeze: false,
                  labelText: 'Select Zone',
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    hint: const Text(
                      'Select Zone',
                      style: TextStyle(fontSize: 13.0),
                    ),
                    value: controller.zoneList
                            .contains(controller.selectZone.value)
                        ? controller.selectZone.value
                        : null,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    iconEnabledColor: AppColors.black,
                    isExpanded: true,
                    isDense: true,
                    onChanged: (value) {
                      if (value != null) {
                        controller.selectZone.value = value;
                      }
                    },
                    items: [
                      ...controller.zoneList.map((item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Row(
                            children: [
                              Obx(() {
                                return Checkbox(
                                  value:
                                      controller.selectedzoneTab.contains(item),
                                  onChanged: (bool? value) {
                                    if (value != null) {
                                      if (value) {
                                        controller.selectedzoneTab.add(item);
                                        controller.selectZone.value = item;
                                      } else {
                                        controller.selectedzoneTab.remove(item);
                                        if (controller.selectZone.value ==
                                            item) {
                                          controller.selectZone.value = '';
                                        }
                                      }
                                    }
                                  },
                                );
                              }),
                              Text(item),
                            ],
                          ),
                        );
                      }),
                      DropdownMenuItem<String>(
                        enabled: false,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                controller.isDataLoaded.value = false;
                                controller.dSRFilterData().then((_) {
                                  controller.isDataLoaded.value = true;
                                });

                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Close'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
        Expanded(
          child: Obx(() {
            return controller.isDataLoaded.value
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.leadersWithZonefilters.length,
                    itemBuilder: (context, index) {
                      return ExpansionTile(
                        title: Text(
                          controller.leadersWithZonefilters[index].typeOfActivity!,
                          style: const TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                        subtitle: Text(
                          '${controller.leadersWithZonefilters[index].dateOfVisit != null ? DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.leadersWithZonefilters[index].dateOfVisit!.toString())) : 'No Date'} | ${controller.leadersWithZonefilters[index].zone}',
                          style: const TextStyle(
                              fontSize: 14.0, color: Colors.grey),
                        ),
                        children: <Widget>[
                          SizedBox(
                            width: 800.0,
                            child: Card(
                              child: Column(
                                children: <Widget>[
                                  DataTable(
                                    columns: [
                                      const DataColumn(
                                          label: Text('Executive')),
                                      DataColumn(
                                          label: Text(controller
                                              .leadersWithZonefilters[index].executive!)),
                                    ],
                                    rows: [
                                      DataRow(cells: [
                                        const DataCell(Text('Team Leader')),
                                        DataCell(Text(controller
                                            .leadersWithZonefilters[index].teamLeader!
                                            .split('.')[0])),
                                      ]),
                                      DataRow(cells: [
                                        const DataCell(Text('Date Of Visit')),
                                        DataCell(Text(DateFormat('yyyy-MM-dd')
                                            .format(DateTime.parse(controller
                                                .leadersWithZonefilters[index].dateOfVisit!
                                                .toString()))))
                                      ]),
                                      DataRow(cells: [
                                        const DataCell(
                                            Text('Type Of Activity')),
                                        DataCell(Text(controller
                                            .leadersWithZonefilters[index].typeOfActivity!)),
                                      ]),
                                      const DataRow(cells: [
                                        DataCell(Text('Sub Category')),
                                        DataCell(Text('')),
                                      ]),
                                      DataRow(cells: [
                                        const DataCell(
                                            Text('Agent Referred Name')),
                                        DataCell(Text(controller
                                            .leadersWithZonefilters[index].agentName!)),
                                      ]),
                                      DataRow(cells: [
                                        const DataCell(
                                            Text('Sub Type Of Activity')),
                                        DataCell(
                                          Text(
                                            () {
                                              try {
                                                String jsonString = controller
                                                    .leadersWithZonefilters[index]
                                                    .responceSubTypeOfActivity!;
                                                var decodedJson =
                                                    jsonDecode(jsonString);

                                                if (decodedJson is List) {
                                                  if (decodedJson.isNotEmpty) {
                                                    var firstElement =
                                                        decodedJson[0];
                                                    return firstElement[
                                                            'subTypeOfActivity'] ??
                                                        'N/A';
                                                  } else {
                                                    return 'No subTypeOfActivity';
                                                  }
                                                } else if (decodedJson is Map) {
                                                  return decodedJson[
                                                          'subTypeOfActivity'] ??
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
                                        const DataCell(Text(
                                            'Premium Collected Including GSt%')),
                                        DataCell(
                                          Text(
                                            () {
                                              try {
                                                String jsonString = controller
                                                    .leadersWithZonefilters[index]
                                                    .responceSubTypeOfActivity!;
                                                var decodedJson =
                                                    jsonDecode(jsonString);

                                                if (decodedJson is List) {
                                                  if (decodedJson.isNotEmpty) {
                                                    var firstElement =
                                                        decodedJson[0];
                                                    return firstElement[
                                                            'premium_Collected'] ??
                                                        'N/A';
                                                  } else {
                                                    return 'No subTypeOfActivity';
                                                  }
                                                } else if (decodedJson is Map) {
                                                  return decodedJson[
                                                          'premium_Collected'] ??
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
                                        const DataCell(
                                            Text('Reporting Manager')),
                                        DataCell(Text(controller
                                            .leadersWithZonefilters[index]
                                            .reportingManager!)),
                                      ]),
                                      DataRow(cells: [
                                        const DataCell(Text('Email')),
                                        DataCell(Text(controller
                                            .leadersWithZonefilters[index].email!)),
                                      ]),
                                      DataRow(cells: [
                                        const DataCell(Text('Agent Name')),
                                        DataCell(Text(controller
                                            .leadersWithZonefilters[index].agentName!)),
                                      ]),
                                      DataRow(cells: [
                                        const DataCell(
                                            Text('Agent Contact No.')),
                                        DataCell(Text(controller
                                            .leadersWithZonefilters[index]
                                            .toWhomMeetNumber!)),
                                      ]),
                                      DataRow(cells: [
                                        const DataCell(Text('Meet Location')),
                                        DataCell(Text(controller
                                            .leadersWithZonefilters[index].location!)),
                                      ]),
                                      const DataRow(cells: [
                                        DataCell(Text('Client/Customer Name')),
                                        DataCell(Text('')),
                                      ]),
                                      DataRow(cells: [
                                        const DataCell(Text('Remark')),
                                        DataCell(Text(controller
                                            .leadersWithZonefilters[index].remarkComments!)),
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
                  )
                : AppLoader.onScreenLoaderWithScaffold();
          }),
        ),
      ],
    );
  }

  Widget activityTab(BuildContext context, {Key? key}) {
    return Column(
      key: key,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            child: Obx(() {
              return InputDecorator(
                decoration: AppInputDecoration.inputDecorationFormWithBorder(
                  isFreeze: false,
                  labelText: 'Select Activity',
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    hint: const Text('Select Activity',
                        style: TextStyle(fontSize: 13.0)),
                    value: controller.activityList
                            .contains(controller.selectActivity.value)
                        ? controller.selectActivity.value
                        : null,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    iconEnabledColor: AppColors.black,
                    isExpanded: true,
                    isDense: true,
                    onChanged: (value) {
                      if (value != null) {
                        controller.selectActivity.value = value;
                      }
                    },
                    items: [
                      ...controller.activityList.map((item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Row(
                            children: [
                              Obx(() {
                                return Checkbox(
                                  value: controller.selectedActivityTab
                                      .contains(item),
                                  onChanged: (bool? value) {
                                    if (value != null) {
                                      if (value) {
                                        controller.selectedActivityTab
                                            .add(item);
                                        controller.selectActivity.value = item;
                                      } else {
                                        controller.selectedActivityTab
                                            .remove(item);
                                        if (controller.selectActivity.value ==
                                            item) {
                                          controller.selectActivity.value = '';
                                        }
                                      }
                                    }
                                  },
                                );
                              }),
                              Text(item),
                            ],
                          ),
                        );
                      }),
                      DropdownMenuItem<String>(
                        enabled: false,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                if (controller.selectedzoneTab.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Zone is required'),
                                    ),
                                  );
                                }
                                controller.isDataLoaded.value = false;
                                controller.dSRFilterData().then((_) {
                                  controller.isDataLoaded.value = true;
                                });
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Close'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
        Expanded(
          child: Obx(() {
            return controller.isDataLoaded.value
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.leadersWithZonefilters.length,
                    itemBuilder: (context, index) {
                      return ExpansionTile(
                        title: Text(
                          controller.leadersWithZonefilters[index].typeOfActivity!,
                          style: const TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                        subtitle: Text(
                          '${controller.leadersWithZonefilters[index].dateOfVisit != null ? DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.leadersWithZonefilters[index].dateOfVisit!.toString())) : 'No Date'} | ${controller.leadersWithZonefilters[index].zone}',
                          style: const TextStyle(
                              fontSize: 14.0, color: Colors.grey),
                        ),
                        children: <Widget>[
                          SizedBox(
                            width: 800.0,
                            child: Card(
                              child: Column(
                                children: <Widget>[
                                  DataTable(
                                    columns: [
                                      const DataColumn(
                                          label: Text('Executive')),
                                      DataColumn(
                                          label: Text(controller
                                              .leadersWithZonefilters[index].executive!)),
                                    ],
                                    rows: [
                                      DataRow(cells: [
                                        const DataCell(Text('Team Leader')),
                                        DataCell(Text(controller
                                            .leadersWithZonefilters[index].teamLeader!
                                            .split('.')[0])),
                                      ]),
                                      DataRow(cells: [
                                        const DataCell(Text('Date Of Visit')),
                                        DataCell(Text(DateFormat('yyyy-MM-dd')
                                            .format(DateTime.parse(controller
                                                .leadersWithZonefilters[index].dateOfVisit!
                                                .toString())))),
                                      ]),
                                      DataRow(cells: [
                                        const DataCell(
                                            Text('Type Of Activity')),
                                        DataCell(Text(controller
                                            .leadersWithZonefilters[index].typeOfActivity!)),
                                      ]),
                                      const DataRow(cells: [
                                        DataCell(Text('Sub Category')),
                                        DataCell(Text('')),
                                      ]),
                                      DataRow(cells: [
                                        const DataCell(
                                            Text('Agent Referred Name')),
                                        DataCell(Text(controller
                                            .leadersWithZonefilters[index].agentName!)),
                                      ]),
                                      DataRow(cells: [
                                        const DataCell(
                                            Text('Sub Type Of Activity')),
                                        DataCell(
                                          Text(
                                            () {
                                              try {
                                                String jsonString = controller
                                                    .leadersWithZonefilters[index]
                                                    .responceSubTypeOfActivity!;
                                                var decodedJson =
                                                    jsonDecode(jsonString);

                                                if (decodedJson is List) {
                                                  if (decodedJson.isNotEmpty) {
                                                    var firstElement =
                                                        decodedJson[0];
                                                    return firstElement[
                                                            'subTypeOfActivity'] ??
                                                        'N/A';
                                                  } else {
                                                    return 'No subTypeOfActivity';
                                                  }
                                                } else if (decodedJson is Map) {
                                                  return decodedJson[
                                                          'subTypeOfActivity'] ??
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
                                        const DataCell(Text(
                                            'Premium Collected Including GSt%')),
                                        DataCell(
                                          Text(
                                            () {
                                              try {
                                                String jsonString = controller
                                                    .leadersWithZonefilters[index]
                                                    .responceSubTypeOfActivity!;
                                                var decodedJson =
                                                    jsonDecode(jsonString);

                                                if (decodedJson is List) {
                                                  if (decodedJson.isNotEmpty) {
                                                    var firstElement =
                                                        decodedJson[0];
                                                    return firstElement[
                                                            'premium_Collected'] ??
                                                        'N/A';
                                                  } else {
                                                    return 'No subTypeOfActivity';
                                                  }
                                                } else if (decodedJson is Map) {
                                                  return decodedJson[
                                                          'premium_Collected'] ??
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
                                        const DataCell(
                                            Text('Reporting Manager')),
                                        DataCell(Text(controller
                                            .leadersWithZonefilters[index]
                                            .reportingManager!)),
                                      ]),
                                      DataRow(cells: [
                                        const DataCell(Text('Email')),
                                        DataCell(Text(controller
                                            .leadersWithZonefilters[index].email!)),
                                      ]),
                                      DataRow(cells: [
                                        const DataCell(Text('Agent Name')),
                                        DataCell(Text(controller
                                            .leadersWithZonefilters[index].agentName!)),
                                      ]),
                                      DataRow(cells: [
                                        const DataCell(
                                            Text('Agent Contact No.')),
                                        DataCell(Text(controller
                                            .leadersWithZonefilters[index]
                                            .toWhomMeetNumber!)),
                                      ]),
                                      DataRow(cells: [
                                        const DataCell(Text('Meet Location')),
                                        DataCell(Text(controller.leadersWithZonefilters[index].location!)),
                                      ]),
                                      const DataRow(cells: [
                                        DataCell(Text('Client/Customer Name')),
                                        DataCell(Text('')),
                                      ]),
                                      DataRow(cells: [
                                        const DataCell(Text('Remark')),
                                        DataCell(Text(controller.leadersWithZonefilters[index].remarkComments!)),
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
                  )
                : AppLoader.onScreenLoaderWithScaffold();
          }),
        ),
      ],
    );
  }

  Widget dateTab(BuildContext context, {Key? key}) {
    return Column(
      key: key,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextField(
                  controller: controller.fromDateController,
                  decoration: InputDecoration(
                    labelText: 'From Date',
                    labelStyle: const TextStyle(fontSize: 15.0),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today,
                          color: Colors.black, size: 20.0),
                      onPressed: () => controller.selectDate(context, true),
                    ),
                  ),
                  readOnly: true,
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: TextField(
                controller: controller.toDateController,
                decoration: InputDecoration(
                  labelText: 'To Date',
                  labelStyle: const TextStyle(fontSize: 15.0),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today,
                        color: Colors.black, size: 20.0),
                    onPressed: () => controller.selectDate(context, false),
                  ),
                ),
                readOnly: true,
              ),
            ),
          ],
        ),
        Expanded(
          child: Obx(() {
            if (controller.isDataLoaded.value) {
              if (controller.leadersWithZonefilters.isEmpty) {
                return const Center(child: Text('No Data'));
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.leadersWithZonefilters.length,
                  itemBuilder: (context, index) {
                    return ExpansionTile(
                      title: Text(
                        controller.leadersWithZonefilters[index].typeOfActivity!,
                        style: const TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        '${controller.leadersWithZonefilters[index].dateOfVisit != null ? DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.leadersWithZonefilters[index].dateOfVisit!.toString())) : 'No Date'} | ${controller.leadersWithZonefilters[index].zone}',
                        style:
                            const TextStyle(fontSize: 14.0, color: Colors.grey),
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
                                            .leadersWithZonefilters[index].executive!)),
                                  ],
                                  rows: [
                                    DataRow(cells: [
                                      const DataCell(Text('Team Leader')),
                                      DataCell(Text(controller
                                          .leadersWithZonefilters[index].teamLeader!
                                          .split('.')[0])),
                                    ]),
                                    DataRow(cells: [
                                      const DataCell(Text('Date Of Visit')),
                                      DataCell(Text(DateFormat('yyyy-MM-dd')
                                          .format(DateTime.parse(controller
                                              .leadersWithZonefilters[index].dateOfVisit!
                                              .toString())))),
                                    ]),
                                    DataRow(cells: [
                                      const DataCell(Text('Type Of Activity')),
                                      DataCell(Text(controller
                                          .leadersWithZonefilters[index].typeOfActivity!)),
                                    ]),
                                    const DataRow(cells: [
                                      DataCell(Text('Sub Category')),
                                      DataCell(Text('')),
                                    ]),
                                    DataRow(cells: [
                                      const DataCell(
                                          Text('Agent Referred Name')),
                                      DataCell(Text(controller
                                          .leadersWithZonefilters[index].agentName!)),
                                    ]),
                                    DataRow(cells: [
                                      const DataCell(
                                          Text('Sub Type Of Activity')),
                                      DataCell(
                                        Text(
                                          () {
                                            try {
                                              String jsonString = controller
                                                  .leadersWithZonefilters[index]
                                                  .responceSubTypeOfActivity!;
                                              var decodedJson =
                                                  jsonDecode(jsonString);

                                              if (decodedJson is List) {
                                                if (decodedJson.isNotEmpty) {
                                                  var firstElement =
                                                      decodedJson[0];
                                                  return firstElement[
                                                          'subTypeOfActivity'] ??
                                                      'N/A';
                                                } else {
                                                  return 'No subTypeOfActivity';
                                                }
                                              } else if (decodedJson is Map) {
                                                return decodedJson[
                                                        'subTypeOfActivity'] ??
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
                                      const DataCell(Text(
                                          'Premium Collected Including GSt%')),
                                      DataCell(
                                        Text(
                                          () {
                                            try {
                                              String jsonString = controller
                                                  .leadersWithZonefilters[index]
                                                  .responceSubTypeOfActivity!;
                                              var decodedJson =
                                                  jsonDecode(jsonString);

                                              if (decodedJson is List) {
                                                if (decodedJson.isNotEmpty) {
                                                  var firstElement =
                                                      decodedJson[0];
                                                  return firstElement[
                                                          'premium_Collected'] ??
                                                      'N/A';
                                                } else {
                                                  return 'No subTypeOfActivity';
                                                }
                                              } else if (decodedJson is Map) {
                                                return decodedJson[
                                                        'premium_Collected'] ??
                                                    'N/A';
                                              } else {
                                                return 'Unexpected JSON format';
                                              }
                                            } catch (e) {
                                              // Print the error to debug
                                              return 'Invalid JSON';
                                            }
                                          }(),
                                        ),
                                      )
                                    ]),
                                    DataRow(cells: [
                                      const DataCell(Text('Reporting Manager')),
                                      DataCell(Text(controller
                                          .leadersWithZonefilters[index].reportingManager!)),
                                    ]),
                                    DataRow(cells: [
                                      const DataCell(Text('Email')),
                                      DataCell(Text(
                                          controller.leadersWithZonefilters[index].email!)),
                                    ]),
                                    DataRow(cells: [
                                      const DataCell(Text('Agent Name')),
                                      DataCell(Text(controller
                                          .leadersWithZonefilters[index].agentName!)),
                                    ]),
                                    DataRow(cells: [
                                      const DataCell(Text('Agent Contact No.')),
                                      DataCell(Text(controller
                                          .leadersWithZonefilters[index].toWhomMeetNumber!)),
                                    ]),
                                    DataRow(cells: [
                                      const DataCell(Text('Meet Location')),
                                      DataCell(Text(controller
                                          .leadersWithZonefilters[index].location!)),
                                    ]),
                                    const DataRow(cells: [
                                      DataCell(Text('Client/Customer Name')),
                                      DataCell(Text('')),
                                    ]),
                                    DataRow(cells: [
                                      const DataCell(Text('Remark')),
                                      DataCell(Text(controller
                                          .leadersWithZonefilters[index].remarkComments!)),
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
            } else {
              return AppLoader.onScreenLoaderWithScaffold();
            }
          }),
        ),
      ],
    );
  }
}