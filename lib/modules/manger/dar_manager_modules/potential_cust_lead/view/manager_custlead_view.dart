import 'package:dsr_clone/shared/routes/app_routes.dart';
import 'package:dsr_clone/shared/style/app_colors.dart';
import 'package:dsr_clone/shared/widget/sideMenu/sidemenu.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../shared/widget/app_loader.dart';
import '../controller/manager_custlead_controller.dart';

class ManagerCustLead extends GetView<ManagerCustLeadController> {
  ManagerCustLead({super.key});
  final ManagerCustLeadController controllerCustLead = Get.put(ManagerCustLeadController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.body,
      appBar: AppBar(title: const Text('Potential Customer lead'),
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
      body: Obx(() {
        return (controllerCustLead.isDataLoaded.value)
            ? pageBody(context)
            : AppLoader.onScreenLoaderWithScaffold();
      }),
    );
  }

    Widget pageBody(BuildContext context) {
      return Obx(() {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: controllerCustLead.responceAgentLeadDetails.length,
          itemBuilder: (context, index) {
            return ListTile(
                title: Text(
                  controllerCustLead.responceAgentLeadDetails[index].name!,
                  style: const TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                  'Total DAR Count : ${controllerCustLead.responceAgentLeadDetails[index].count} | Total Premium : ${controllerCustLead.responceAgentLeadDetails[index].sum ?? '0'} ',
                  style: const TextStyle(fontSize: 14.0, color: Colors.grey),
                ),
                onTap: () async {
                  final itemId =
                  controllerCustLead.responceAgentLeadDetails[index].id;
                  final itemIdInt = itemId!.toInt();
                  final flag = controllerCustLead.responceAgentLeadDetails[index].flag;
                  controllerCustLead.isDataLoaded.value = false;

                  await controllerCustLead.getManagerDashData({'id': itemIdInt, 'flag': flag});
                  controllerCustLead.isDataLoaded.value = true;
                });
          },
        );
      });
    }
}
