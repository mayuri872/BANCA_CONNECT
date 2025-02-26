import 'package:dsr_clone/shared/style/app_colors.dart';
import 'package:dsr_clone/shared/widget/sideMenu/sidemenu.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../shared/routes/app_routes.dart';
import '../../../../../shared/widget/app_loader.dart';
import '../../manger_dashboard/controller/manager_dashboard_controller.dart';
import '../controller/manager_agentlead_controller.dart';

class ManagerAgentLead extends GetView<ManagerDashboardController> {
  ManagerAgentLead({super.key});
  final ManagerAgentLeadController controllerAgentLead = Get.put(ManagerAgentLeadController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.body,
      appBar: AppBar(title: const Text('Potential Agent lead'),
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
        return (controllerAgentLead.isDataLoaded.value)
            ? pageBody(context)
            : AppLoader.onScreenLoaderWithScaffold();
      }),
    );
  }

    Widget pageBody(BuildContext context) {
      return Obx(() {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: controllerAgentLead.responceAgentLeadDetails.length,
          itemBuilder: (context, index) {
            return ListTile(
                title: Text(
                  controllerAgentLead.responceAgentLeadDetails[index].name!,
                  style: const TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                  'Total DAR Count : ${controllerAgentLead.responceAgentLeadDetails[index].count} | Total Premium : ${controllerAgentLead.responceAgentLeadDetails[index].sum ?? '0'} ',
                  style: const TextStyle(fontSize: 14.0, color: Colors.grey),
                ),
                onTap: () async {
                  final itemId =
                  controllerAgentLead.responceAgentLeadDetails[index].id;
                  final itemIdInt = itemId!.toInt();
                  final flag = controllerAgentLead.responceAgentLeadDetails[index].flag;
                  controllerAgentLead.isDataLoaded.value = false;

                  await controllerAgentLead.getManagerDashData({'id': itemIdInt, 'flag': flag});
                  controllerAgentLead.isDataLoaded.value = true;
                });
          },
        );
      });
    }
}
