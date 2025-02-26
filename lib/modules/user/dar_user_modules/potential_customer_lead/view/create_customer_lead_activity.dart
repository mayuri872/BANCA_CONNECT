import 'package:dsr_clone/shared/style/app_colors.dart';
import 'package:dsr_clone/shared/style/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../shared/routes/app_routes.dart';
import '../../../../../shared/style/app_input_decoration.dart';
import '../../../../../shared/style/app_padding.dart';
import '../../../../../shared/widget/custom_text_field.dart';
import '../controller/customer_lead_controller.dart';

class CreateCustomerLeadActivity extends GetView<CustomerLeadController> {
  CreateCustomerLeadActivity({super.key});

  final List<String> subCategoryList = <String>[
    'Self',
    'Agent Referred',
  ];

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Lead Activity'),
        leading: BackButton(
          style: ButtonStyle(iconSize: WidgetStateProperty.all(20)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: pageBody(context, size),
    );
  }

  Widget pageBody(BuildContext context, Size screenSize) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
      child: SingleChildScrollView(
        child: Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomTextField(
                    controller: controller.dateController,
                    hintText: 'Date of Visit',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the date of visit';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: screenSize.height * 0.02,
                  ),
                  CustomTextField(
                    controller: controller.typeOfActivityController,
                    hintText: 'Type Of Activity',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the type of activity';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: screenSize.height * 0.02,
                  ),
                  InputDecorator(
                    decoration: AppInputDecoration.inputDecorationFormWithBorder(
                      isFreeze: false,
                      labelText: 'Sub Category',
                    ),
                    child: Obx(
                      () => DropdownButton<String>(
                        value: subCategoryList.contains(controller.subCategory.value)
                            ? controller.subCategory.value
                            : null,
                        hint: const Text('Select Sub Category'),
                        underline: Container(),
                        style: const TextStyle(fontSize: 12, color: AppColors.black),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        iconEnabledColor: AppColors.black,
                        isExpanded: true,
                        isDense: true,
                        onChanged: (value) {
                          if (value != null) {
                            controller.subCategory.value = value;
                            controller.getAgentLeadApiData();
                          }
                        },
                        items: subCategoryList.map((item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item, style: const TextStyle(fontSize: 12)),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.02,
                  ),
                  Obx(() {
                    if (controller.subCategory.value == 'Agent Referred') {
                      return InputDecorator(
                        decoration: AppInputDecoration.inputDecorationFormWithBorder(
                          isFreeze: false,
                          labelText: 'Agent name',
                        ),
                        child: Obx(
                          () => DropdownButton<String>(
                            value: controller.agentList.contains(controller.typOfAgentName.value)
                                ? controller.typOfAgentName.value
                                : null,
                            hint: const Text('Select type of activity'),
                            underline: Container(),
                            style: const TextStyle(fontSize: 12, color: AppColors.black),
                            icon: const Icon(Icons.keyboard_arrow_down),
                            iconEnabledColor: AppColors.black,
                            isExpanded: true,
                            isDense: true,
                            onChanged: (value) {
                              if (value != null) {
                                controller.typOfAgentName.value = value;
                              }
                            },
                            items: controller.agentList.map((item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                child: Text(item, style: const TextStyle(fontSize: 12)),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  }),
                  SizedBox(
                    height: screenSize.height * 0.02,
                  ),
                  CustomTextField(
                    controller: controller.totalPremiumController,
                    hintText: 'Potential Premium per Month',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the potential premium per month';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: screenSize.height * 0.02,
                  ),
                  CustomTextField(
                    controller: controller.agentNameController,
                    hintText: 'Customer / client Name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the customer/client name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: screenSize.height * 0.02,
                  ),
                  CustomTextField(
                    controller: controller.emailController,
                    hintText: 'Customer Email',
                    validator: (value) {
                      if (value == null || value.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: screenSize.height * 0.02,
                  ),
                  CustomTextField(
                    controller: controller.agentContactNoController,
                    hintText: 'Customer Contact Number',
                    maxLength: 10,
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length != 10) {
                        return 'Please enter a valid contact number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: screenSize.height * 0.02,
                  ),
                  CustomTextField(
                    controller: controller.locationController,
                    hintText: 'Customer Meet Location',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the meet location';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: screenSize.height * 0.02,
                  ),
                  Obx(() {
                    return Column(
                      children: [
                        SizedBox(
                          child: InputDecorator(
                            decoration: AppInputDecoration.inputDecorationFormWithBorder(
                              isFreeze: false,
                              labelText: 'Proposed Product',
                            ),
                            child: DropdownButton<String>(
                              value: controller.proposedProductionList.contains(controller.proposedProductType.value)
                                  ? controller.proposedProductType.value
                                  : null,
                              hint: const Text('Select Competition Information'),
                              underline: Container(),
                              style: const TextStyle(fontSize: 12, color: AppColors.black),
                              icon: const Icon(Icons.keyboard_arrow_down),
                              iconEnabledColor: AppColors.black,
                              isExpanded: true,
                              isDense: true,
                              onChanged: (value) {
                                if (value != null) {
                                  controller.proposedProductType.value = value;
                                }
                              },
                              items: controller.proposedProductionList.map((item) {
                                return DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(item, style: const TextStyle(fontSize: 12)),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                  SizedBox(
                    height: screenSize.height * 0.02,
                  ),
                  CustomTextField(
                    controller: controller.remarkController,
                    hintText: 'Remark',
                    maxLines: 3,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a remark';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: screenSize.height * 0.02,
                  ),
                  submitButton(context),
                ],
              ),
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
          if (_formKey.currentState!.validate()) {
            await controller.createAgentLeadActivity();
            controller.update();
            Get.offAllNamed(AppRoutes.customerLeadActivityReport);
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