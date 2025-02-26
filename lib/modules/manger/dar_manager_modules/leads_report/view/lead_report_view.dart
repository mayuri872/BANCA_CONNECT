import 'package:dsr_clone/modules/manger/dar_manager_modules/leads_report/controller/lead_report_controller.dart';
import 'package:dsr_clone/shared/style/app_colors.dart';
import 'package:dsr_clone/shared/widget/sideMenu/sidemenu.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../shared/routes/app_routes.dart';
import '../../../../../shared/style/app_input_decoration.dart';
import '../../../../../shared/widget/app_loader.dart';

class LeadReportView extends GetView<LeadReportController> {
  LeadReportView({super.key});
  @override
  final LeadReportController controller = Get.put(LeadReportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.body,
        appBar: AppBar(
          title: const Text('Lead Report'),
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
        ));
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
                    itemCount: controller.responceZoneManagerfilters.length,
                    itemBuilder: (context, index) {
                      return ExpansionTile(
                        title: Text(
                          controller.responceZoneManagerfilters[index]
                              .typeOfActivity!,
                          style: const TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                        subtitle: Text(
                          '${controller.responceZoneManagerfilters[index].dateOfVisit != null ? DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.responceZoneManagerfilters[index].dateOfVisit!.toString())) : 'No Date'} | ${controller.responceZoneManagerfilters[index].zone}',
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
                                              .responceZoneManagerfilters[index]
                                              .executive!)),
                                    ],
                                    rows: [
                                      DataRow(cells: [
                                        const DataCell(Text('Team Leader')),
                                        DataCell(Text(controller
                                            .responceZoneManagerfilters[index]
                                            .teamLeader!
                                            .split('.')[0])),
                                      ]),
                                      DataRow(cells: [
                                        const DataCell(Text('Date Of Visit')),
                                        DataCell(Text(DateFormat('yyyy-MM-dd')
                                            .format(DateTime.parse(controller
                                                .responceZoneManagerfilters[
                                                    index]
                                                .dateOfVisit!
                                                .toString()))))
                                      ]),
                                      DataRow(cells: [
                                        const DataCell(
                                            Text('Type Of Activity')),
                                        DataCell(Text(controller
                                            .responceZoneManagerfilters[index]
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
                                            .responceZoneManagerfilters[index]
                                            .agentName!)),
                                      ]),
                                      const DataRow(cells: [
                                        DataCell(Text('Sub Type Of Activity')),
                                        DataCell(Text('')),
                                      ]),
                                      const DataRow(cells: [
                                        DataCell(Text(
                                            'Premium Collected Including GSt%')),
                                        DataCell(Text('')),
                                      ]),
                                      DataRow(cells: [
                                        const DataCell(Text('Email')),
                                        DataCell(Text(controller
                                            .responceZoneManagerfilters[index]
                                            .email!)),
                                      ]),
                                      DataRow(cells: [
                                        const DataCell(Text('Agent Name')),
                                        DataCell(Text(controller
                                            .responceZoneManagerfilters[index]
                                            .agentName!)),
                                      ]),
                                      DataRow(cells: [
                                        const DataCell(
                                            Text('Agent Contact No.')),
                                        DataCell(Text(controller
                                            .responceZoneManagerfilters[index]
                                            .toWhomMeetNumber!)),
                                      ]),
                                      DataRow(cells: [
                                        const DataCell(Text('Meet Location')),
                                        DataCell(Text(controller
                                            .responceZoneManagerfilters[index]
                                            .location!)),
                                      ]),
                                      const DataRow(cells: [
                                        DataCell(Text('Client/Customer Name')),
                                        DataCell(Text('')),
                                      ]),
                                      DataRow(cells: [
                                        const DataCell(Text('Remark')),
                                        DataCell(Text(controller
                                            .responceZoneManagerfilters[index]
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
                    itemCount: controller.dSRFilter.length,
                    itemBuilder: (context, index) {
                      return ExpansionTile(
                        title: Text(
                          controller.dSRFilter[index].typeOfActivity!,
                          style: const TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                        subtitle: Text(
                          '${controller.dSRFilter[index].dateOfVisit != null ? DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.dSRFilter[index].dateOfVisit!.toString())) : 'No Date'} | ${controller.dSRFilter[index].zone}',
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
                                              .dSRFilter[index].executive!)),
                                    ],
                                    rows: [
                                      DataRow(cells: [
                                        const DataCell(Text('Team Leader')),
                                        DataCell(Text(controller
                                            .dSRFilter[index].teamLeader!
                                            .split('.')[0])),
                                      ]),
                                      DataRow(cells: [
                                        const DataCell(Text('Date Of Visit')),
                                        DataCell(Text(DateFormat('yyyy-MM-dd')
                                            .format(DateTime.parse(controller
                                                .dSRFilter[index].dateOfVisit!
                                                .toString()))))
                                      ]),
                                      DataRow(cells: [
                                        const DataCell(
                                            Text('Type Of Activity')),
                                        DataCell(Text(controller
                                            .dSRFilter[index].typeOfActivity!)),
                                      ]),
                                      const DataRow(cells: [
                                        DataCell(Text('Sub Category')),
                                        DataCell(Text('')),
                                      ]),
                                      DataRow(cells: [
                                        const DataCell(
                                            Text('Agent Referred Name')),
                                        DataCell(Text(controller
                                            .dSRFilter[index].agentName!)),
                                      ]),
                                      const DataRow(cells: [
                                        DataCell(Text('Sub Type Of Activity')),
                                        DataCell(Text('')),
                                      ]),
                                      const DataRow(cells: [
                                        DataCell(Text(
                                            'Premium Collected Including GSt%')),
                                        DataCell(Text('')),
                                      ]),
                                      DataRow(cells: [
                                        const DataCell(
                                            Text('Reporting Manager')),
                                        DataCell(Text(controller
                                            .dSRFilter[index]
                                            .reportingManager!)),
                                      ]),
                                      DataRow(cells: [
                                        const DataCell(Text('Email')),
                                        DataCell(Text(controller
                                            .dSRFilter[index].email!)),
                                      ]),
                                      DataRow(cells: [
                                        const DataCell(Text('Agent Name')),
                                        DataCell(Text(controller
                                            .dSRFilter[index].agentName!)),
                                      ]),
                                      DataRow(cells: [
                                        const DataCell(
                                            Text('Agent Contact No.')),
                                        DataCell(Text(controller
                                            .dSRFilter[index]
                                            .toWhomMeetNumber!)),
                                      ]),
                                      DataRow(cells: [
                                        const DataCell(Text('Meet Location')),
                                        DataCell(Text(controller
                                            .dSRFilter[index].location!)),
                                      ]),
                                      const DataRow(cells: [
                                        DataCell(Text('Client/Customer Name')),
                                        DataCell(Text('')),
                                      ]),
                                      DataRow(cells: [
                                        const DataCell(Text('Remark')),
                                        DataCell(Text(controller
                                            .dSRFilter[index].remarkComments!)),
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
                    itemCount: controller.dSRFilter.length,
                    itemBuilder: (context, index) {
                      return ExpansionTile(
                        title: Text(
                          controller.dSRFilter[index].typeOfActivity!,
                          style: const TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                        subtitle: Text(
                          '${controller.dSRFilter[index].dateOfVisit != null ? DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.dSRFilter[index].dateOfVisit!.toString())) : 'No Date'} | ${controller.dSRFilter[index].zone}',
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
                                              .dSRFilter[index].executive!)),
                                    ],
                                    rows: [
                                      DataRow(cells: [
                                        const DataCell(Text('Team Leader')),
                                        DataCell(Text(controller
                                            .dSRFilter[index].teamLeader!
                                            .split('.')[0])),
                                      ]),
                                      DataRow(cells: [
                                        const DataCell(Text('Date Of Visit')),
                                        DataCell(Text(DateFormat('yyyy-MM-dd')
                                            .format(DateTime.parse(controller
                                                .dSRFilter[index].dateOfVisit!
                                                .toString())))),
                                      ]),
                                      DataRow(cells: [
                                        const DataCell(
                                            Text('Type Of Activity')),
                                        DataCell(Text(controller
                                            .dSRFilter[index].typeOfActivity!)),
                                      ]),
                                      const DataRow(cells: [
                                        DataCell(Text('Sub Category')),
                                        DataCell(Text('')),
                                      ]),
                                      DataRow(cells: [
                                        const DataCell(
                                            Text('Agent Referred Name')),
                                        DataCell(Text(controller
                                            .dSRFilter[index].agentName!)),
                                      ]),
                                      const DataRow(cells: [
                                        DataCell(Text('Sub Type Of Activity')),
                                        DataCell(Text('')),
                                      ]),
                                      const DataRow(cells: [
                                        DataCell(Text(
                                            'Premium Collected Including GSt%')),
                                        DataCell(Text('')),
                                      ]),
                                      DataRow(cells: [
                                        const DataCell(
                                            Text('Reporting Manager')),
                                        DataCell(Text(controller
                                            .dSRFilter[index]
                                            .reportingManager!)),
                                      ]),
                                      DataRow(cells: [
                                        const DataCell(Text('Email')),
                                        DataCell(Text(controller
                                            .dSRFilter[index].email!)),
                                      ]),
                                      DataRow(cells: [
                                        const DataCell(Text('Agent Name')),
                                        DataCell(Text(controller
                                            .dSRFilter[index].agentName!)),
                                      ]),
                                      DataRow(cells: [
                                        const DataCell(
                                            Text('Agent Contact No.')),
                                        DataCell(Text(controller
                                            .dSRFilter[index]
                                            .toWhomMeetNumber!)),
                                      ]),
                                      DataRow(cells: [
                                        const DataCell(Text('Meet Location')),
                                        DataCell(Text(controller
                                            .dSRFilter[index].location!)),
                                      ]),
                                      const DataRow(cells: [
                                        DataCell(Text('Client/Customer Name')),
                                        DataCell(Text('')),
                                      ]),
                                      DataRow(cells: [
                                        const DataCell(Text('Remark')),
                                        DataCell(Text(controller
                                            .dSRFilter[index].remarkComments!)),
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
              if (controller.dSRFilter.isEmpty) {
                return const Center(child: Text('No Data'));
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.dSRFilter.length,
                  itemBuilder: (context, index) {
                    return ExpansionTile(
                      title: Text(
                        controller.dSRFilter[index].typeOfActivity!,
                        style: const TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        '${controller.dSRFilter[index].dateOfVisit != null ? DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.dSRFilter[index].dateOfVisit!.toString())) : 'No Date'} | ${controller.dSRFilter[index].zone}',
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
                                            .dSRFilter[index].executive!)),
                                  ],
                                  rows: [
                                    DataRow(cells: [
                                      const DataCell(Text('Team Leader')),
                                      DataCell(Text(controller
                                          .dSRFilter[index].teamLeader!
                                          .split('.')[0])),
                                    ]),
                                    DataRow(cells: [
                                      const DataCell(Text('Date Of Visit')),
                                      DataCell(Text(DateFormat('yyyy-MM-dd')
                                          .format(DateTime.parse(controller
                                              .dSRFilter[index].dateOfVisit!
                                              .toString())))),
                                    ]),
                                    DataRow(cells: [
                                      const DataCell(Text('Type Of Activity')),
                                      DataCell(Text(controller
                                          .dSRFilter[index].typeOfActivity!)),
                                    ]),
                                    const DataRow(cells: [
                                      DataCell(Text('Sub Category')),
                                      DataCell(Text('')),
                                    ]),
                                    DataRow(cells: [
                                      const DataCell(
                                          Text('Agent Referred Name')),
                                      DataCell(Text(controller
                                          .dSRFilter[index].agentName!)),
                                    ]),
                                    const DataRow(cells: [
                                      DataCell(Text('Sub Type Of Activity')),
                                      DataCell(Text('')),
                                    ]),
                                    const DataRow(cells: [
                                      DataCell(Text(
                                          'Premium Collected Including GSt%')),
                                      DataCell(Text('')),
                                    ]),
                                    DataRow(cells: [
                                      const DataCell(Text('Reporting Manager')),
                                      DataCell(Text(controller
                                          .dSRFilter[index].reportingManager!)),
                                    ]),
                                    DataRow(cells: [
                                      const DataCell(Text('Email')),
                                      DataCell(Text(
                                          controller.dSRFilter[index].email!)),
                                    ]),
                                    DataRow(cells: [
                                      const DataCell(Text('Agent Name')),
                                      DataCell(Text(controller
                                          .dSRFilter[index].agentName!)),
                                    ]),
                                    DataRow(cells: [
                                      const DataCell(Text('Agent Contact No.')),
                                      DataCell(Text(controller
                                          .dSRFilter[index].toWhomMeetNumber!)),
                                    ]),
                                    DataRow(cells: [
                                      const DataCell(Text('Meet Location')),
                                      DataCell(Text(controller
                                          .dSRFilter[index].location!)),
                                    ]),
                                    const DataRow(cells: [
                                      DataCell(Text('Client/Customer Name')),
                                      DataCell(Text('')),
                                    ]),
                                    DataRow(cells: [
                                      const DataCell(Text('Remark')),
                                      DataCell(Text(controller
                                          .dSRFilter[index].remarkComments!)),
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
