import 'package:dropdown_search/dropdown_search.dart';
import 'package:dsr_clone/shared/style/app_colors.dart';
import 'package:dsr_clone/shared/style/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../shared/routes/app_routes.dart';
import '../../../../../shared/style/app_input_decoration.dart';
import '../../../../../shared/style/app_padding.dart';
import '../../../../../shared/widget/custom_text_field.dart';
import '../../potential_customer_lead/controller/customer_lead_controller.dart';
import '../controller/dar_activity_controller.dart';

class AddDailyActivityReport extends GetView<DarActivityController> {
  final CustomerLeadController controllerLead =
      Get.put(CustomerLeadController());
  AddDailyActivityReport({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Create Daily Activity'),
          leading: BackButton(
            style: ButtonStyle(iconSize: WidgetStateProperty.all(20)),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),

        //drawer: const SideMenu(),
        body: pageBody(context, size));
  }

  Widget pageBody(BuildContext context, Size screenSize) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
      child: SingleChildScrollView(
        child: Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomTextField(
                  controller: controller.dateController,
                  hintText: 'Date of Visit',
                ),
                SizedBox(
                  height: screenSize.height * 0.02,
                ),
                SizedBox(
                  child: InputDecorator(
                    decoration:
                        AppInputDecoration.inputDecorationFormWithBorder(
                      isFreeze: false,
                      labelText: 'Type of activity',
                    ),
                    child: Obx(
                      () => DropdownButton<String>(
                        value: controller.activitylist
                                .contains(controller.activityType.value)
                            ? controller.activityType.value
                            : null,
                        hint: const Text('Select Type of activity'),
                        underline: Container(),
                        style: const TextStyle(
                            fontSize: 12, color: AppColors.black),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        iconEnabledColor: AppColors.black,
                        isExpanded: true,
                        isDense: true,
                        onChanged: (value) async {
                          if (value != null) {
                            controller.activityType.value = value;
                            controller.getSubTypeOfAcitivityApiData(value);
                            if (controller.activityType.value == 'Sales Call') {
                              controllerLead.getAgentLeadApiData();
                              controller.getDSRCustLeadDtlsApiData();
                            } else {
                              controller.getDSRAgentLeadDtlsApiData();
                            }
                          }
                        },
                        items: controller.activitylist.map((item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item,
                                style: const TextStyle(fontSize: 12)),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenSize.height * 0.02,
                ),
                Obx(() {
                  if (controller.activityType.value == 'Sales Call') {
                    return SizedBox(
                      child: InputDecorator(
                        decoration:
                            AppInputDecoration.inputDecorationFormWithBorder(
                          isFreeze: false,
                          labelText: 'Sub Category',
                        ),
                        child: Obx(
                          () => DropdownButton<String>(
                            value: controller.subCategoryList
                                    .contains(controller.subCategory.value)
                                ? controller.subCategory.value
                                : null,
                            hint: const Text('Select Sub Category'),
                            underline: Container(),
                            style: const TextStyle(
                                fontSize: 12, color: AppColors.black),
                            icon: const Icon(Icons.keyboard_arrow_down),
                            iconEnabledColor: AppColors.black,
                            isExpanded: true,
                            isDense: true,
                            onChanged: (value) {
                              if (value != null) {
                                controller.subCategory.value = value;
                              }
                            },
                            items: controller.subCategoryList.map((item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                child: Text(item,
                                    style: const TextStyle(fontSize: 12)),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    );
                  } else if (controller.activityType.value ==
                      'Recruitment Call') {
                    return Container();
                  } else {
                    return SizedBox(
                      child: InputDecorator(
                        decoration:
                            AppInputDecoration.inputDecorationFormWithBorder(
                          isFreeze: false,
                          labelText: 'Sub Category',
                        ),
                        child: Obx(
                          () => DropdownButton<String>(
                            value: controller.subCategoryList
                                    .contains(controller.subCategory.value)
                                ? controller.subCategory.value
                                : null,
                            hint: const Text('Select Sub Category'),
                            underline: Container(),
                            style: const TextStyle(
                                fontSize: 12, color: AppColors.black),
                            icon: const Icon(Icons.keyboard_arrow_down),
                            iconEnabledColor: AppColors.black,
                            isExpanded: true,
                            isDense: true,
                            onChanged: (value) {
                              if (value != null) {
                                controller.subCategory.value = value;
                              }
                            },
                            items: controller.subCategoryList.map((item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                child: Text(item,
                                    style: const TextStyle(fontSize: 12)),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    );
                  }
                }),
                Obx(() {
                  if (controller.activityType.value == 'Recruitment Call') {
                    return SizedBox(
                      child: InputDecorator(
                        decoration:
                            AppInputDecoration.inputDecorationFormWithBorder(
                          isFreeze: false,
                          labelText: 'Accompanied',
                        ),
                        child: DropdownButton<String>(
                          value: controller.leadList
                                  .contains(controller.leadType.value)
                              ? controller.leadType.value
                              : null,
                          hint: const Text('Select type of lead'),
                          underline: Container(),
                          style: const TextStyle(
                              fontSize: 12, color: AppColors.black),
                          icon: const Icon(Icons.keyboard_arrow_down),
                          iconEnabledColor: AppColors.black,
                          isExpanded: true,
                          isDense: true,
                          onChanged: (value) {
                            if (value != null) {
                              controller.leadType.value = value;
                            }
                          },
                          items: controller.leadList.map((item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item,
                                  style: const TextStyle(fontSize: 12)),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                }),
                SizedBox(
                  height: screenSize.height * 0.02,
                ),
                Obx(() {
                  if ((controller.activityType.value == 'Recruitment Call' &&
                          controller.leadType.value == 'Manager') ||
                      (controller.activityType.value == 'Sales Call' &&
                          controller.subCategory.value == 'Agent Referred')) {
                    return CustomTextField(
                      controller: controller.reportingManagerController,
                      hintText: 'Reporting Manager Name',
                    );
                  } else {
                    return Container();
                  }
                }),
                SizedBox(
                  height: screenSize.height * 0.02,
                ),
                Column(
                  children: [
                    Obx(() {
                      if (controller.activityType.value == 'Recruitment Call' ||
                          controller.activityType.value == 'Sales Call' &&
                              controller.subCategory.value ==
                                  'Agent Referred') {
                        return Column(
                          children: [
                            SizedBox(
                              child: InputDecorator(
                                decoration: AppInputDecoration
                                    .inputDecorationFormWithBorder(
                                  isFreeze: false,
                                  labelText: 'Sub Type of activity',
                                ),
                                child: DropdownButton<String>(
                                  value: controller.subTypeOfAcitivityList
                                          .contains(
                                              controller.subActivityType.value)
                                      ? controller.subActivityType.value
                                      : null,
                                  hint:
                                      const Text('Select Sub Type of activity'),
                                  underline: Container(),
                                  style: const TextStyle(
                                      fontSize: 12, color: AppColors.black),
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  iconEnabledColor: AppColors.black,
                                  isExpanded: true,
                                  isDense: true,
                                  onChanged: (value) {
                                    if (value != null) {
                                      controller.subActivityType.value = value;
                                    }
                                  },
                                  items: controller.subTypeOfAcitivityList
                                      .map((item) {
                                    return DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(item,
                                          style: const TextStyle(fontSize: 12)),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Container();
                      }
                    }),
                    SizedBox(height: screenSize.height * 0.01),
                    if (controller.activityType.value == 'Sales Call' &&
                        controller.subCategory.value == 'Agent Referred')
                      CustomTextField(
                        controller: controller.collectedGStController,
                        hintText: 'Premium Collected Including GST',
                      ),
                  ],
                ),
                SizedBox(
                  height: screenSize.height * 0.02,
                ),
                Obx(() {
                  if (controller.activityType.value == 'Sales Call') {
                    return SizedBox(
                      child: InputDecorator(
                        decoration:
                            AppInputDecoration.inputDecorationFormWithBorder(
                          isFreeze: false,
                          labelText: 'Agent Details',
                        ),
                        child: DropdownButton<String>(
                          value: controllerLead.agentList
                                  .contains(controllerLead.typOfAgentName.value)
                              ? controllerLead.typOfAgentName.value
                              : null,
                          hint: const Text('Select type of activity'),
                          underline: Container(),
                          style: const TextStyle(
                              fontSize: 12, color: AppColors.black),
                          icon: const Icon(Icons.keyboard_arrow_down),
                          iconEnabledColor: AppColors.black,
                          isExpanded: true,
                          isDense: true,
                          onChanged: (value) {
                            if (value != null) {
                              controllerLead.typOfAgentName.value = value;
                              final selectedAgent = controllerLead
                                  .responceAgentDetailst
                                  .firstWhere(
                                (agent) =>
                                    '${agent.agentName} - ${agent.agentCode}' ==
                                    value,
                              );
                              controller.emailController.text =
                                  selectedAgent.agentEmail;
                              controller.agentNameController.text =
                                  selectedAgent.agentName;
                              controller.agentContactNoController.text =
                                  selectedAgent.agentContact;
                            }
                          },
                          items: controllerLead.agentList.map((item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item,
                                  style: const TextStyle(fontSize: 12)),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                }),
                Obx(() {
                  if (controller.activityType.value == 'Recruitment Call') {
                    return SizedBox(
                      child: InputDecorator(
                        decoration:
                            AppInputDecoration.inputDecorationFormWithBorder(
                          isFreeze: false,
                          labelText: 'Agent Lead Details',
                        ),
                        child: DropdownSearch<String>(
                          popupProps: PopupProps.menu(
                            showSearchBox: true,
                            itemBuilder: (context, item, isSelected) {
                              return ListTile(
                                title: Text(item,
                                    style: const TextStyle(fontSize: 12)),
                              );
                            },
                          ),
                          items: controller.agentLeadDetailsList,
                          selectedItem: controller.agentLeadDetailsList.contains(controller.agentLeadType.value)
                              ? controller.agentLeadType.value
                              : null,
                          dropdownDecoratorProps: const DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              hintText: 'Select type of activity',
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                            fontSize: 12, color: AppColors.black),
                            ),
                          ),
                          onChanged: (value) {
                            if (value != null) {
                              controller.agentLeadType.value = value;
                              final selectedAgentLead = controller
                                  .responceDailyAcitvityDetails
                                  .firstWhere(
                                (agent) => agent.toWhomMeet == value,
                              );
                              controller.emailController.text = selectedAgentLead.email!;
                              controller.agentNameController.text = selectedAgentLead.toWhomMeet!;
                              controller.agentContactNoController.text = selectedAgentLead.toWhomMeetNumber!;
                            }
                          },
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                }),
                SizedBox(
                  height: screenSize.height * 0.01,
                ),
                Obx(() {
                  if (controller.activityType.value == 'Sales Call') {
                    return SizedBox(
                      child: InputDecorator(
                        decoration:
                            AppInputDecoration.inputDecorationFormWithBorder(
                          isFreeze: false,
                          labelText: 'Customer Lead Details',
                        ),
                        child: DropdownSearch<String>(
                          popupProps: PopupProps.menu(
                            showSearchBox: true,
                            itemBuilder: (context, item, isSelected) {
                              return ListTile(
                                title: Text(item,
                                    style: const TextStyle(fontSize: 12)),
                              );
                            },
                          ),
                          items: controller.custLeadDetailsList,
                          selectedItem: controller.custLeadDetailsList
                                  .contains(controller.customerLeadType.value)
                              ? controller.customerLeadType.value
                              : null,
                          dropdownDecoratorProps: const DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              hintText: 'Select type of activity',
                              border: InputBorder.none,
                               hintStyle: TextStyle(
                            fontSize: 12, color: AppColors.black),
                            ),
                          ),
                          onChanged: (value) {
                            if (value != null) {
                              controller.customerLeadType.value = value;
                            }
                          },
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                }),
                SizedBox(
                  height: screenSize.height * 0.01,
                ),
                Obx(() {
                  if (controller.activityType.value == 'Recruitment Call' ||
                      controller.activityType.value == 'Sales Call') {
                    return CustomTextField(
                      controller: controller.agentNameController,
                      hintText: 'Agent Name',
                    );
                  } else {
                    return Container();
                  }
                }),
                SizedBox(
                  height: screenSize.height * 0.02,
                ),
                Obx(() {
                  if (controller.activityType.value == 'Recruitment Call' ||
                      controller.activityType.value == 'Sales Call') {
                    return CustomTextField(
                      controller: controller.emailController,
                      hintText: 'Email',
                    );
                  } else {
                    return Container();
                  }
                }),
                SizedBox(
                  height: screenSize.height * 0.02,
                ),
                Obx(() {
                  if (controller.activityType.value == 'Recruitment Call' ||
                      controller.activityType.value == 'Sales Call') {
                    return CustomTextField(
                      controller: controller.agentContactNoController,
                      hintText: 'Agent Contact Number',
                      maxLength: 10,
                    );
                  } else {
                    return Container();
                  }
                }),
                SizedBox(
                  height: screenSize.height * 0.02,
                ),
                CustomTextField(
                  controller: controller.remarkController,
                  hintText: 'Other Remark Comments',
                  maxLines: 3,
                ),
                SizedBox(
                  height: screenSize.height * 0.02,
                ),
                submitButton(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget submitButton(BuildContext context) {
    return Padding(
      padding: AppPadding().inputPadding,
      child: ElevatedButton(
        onPressed: () async {
          await controller.addDailyActivityRecord();
          controller.update();
          Get.offAllNamed(AppRoutes.darActivityReport);
          if (controller.todayActivityCount == 2) {
            controller.markAttendance();
          }
        },
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.primary2,
          fixedSize: Size(MediaQuery.of(context).size.width, 50.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Text('Submit', style: AppTextStyle.btnTextStyleWhite()),
      ),
    );
  }
}
