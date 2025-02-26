import 'package:dsr_clone/shared/style/app_colors.dart';
import 'package:dsr_clone/shared/widget/sideMenu/sidemenu.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../shared/routes/app_routes.dart';
import '../../../../../shared/widget/app_loader.dart';
import '../controller/teams_controller.dart';

class TeamsView extends GetView<TeamsController> {
  TeamsView({super.key});
  final TeamsController controllerTeams = Get.put(TeamsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.body,
      appBar: AppBar(title: const Text('Teams Activity'),
      leading: BackButton(
          style: ButtonStyle(iconSize: WidgetStateProperty.all(20)),
          onPressed: () {
            if (kIsWeb) {
          Get.offNamed(AppRoutes.webdashboard);
        } else {
          Get.offNamed(AppRoutes.dashboard);
        }
          }
        )
      ),
      drawer: const SideMenu(),
      body: Obx(() {
        return (controllerTeams.isDataLoaded.value)
            ? pageBody(context)
            : AppLoader.onScreenLoaderWithScaffold();
      }),
    );
  }

  Widget pageBody(BuildContext context) {
    return Obx(() {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: controllerTeams.responceTeamActivityDetails.length,
        itemBuilder: (context, index) {
          return ListTile(
              title: Text(
                controllerTeams.responceTeamActivityDetails[index].name!,
                style: const TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),
              subtitle: Text(
                'Total DAR Count : ${controllerTeams.responceTeamActivityDetails[index].count} | Total Premium : ${controllerTeams.responceTeamActivityDetails[index].sum ?? '0'} ',
                style: const TextStyle(fontSize: 14.0, color: Colors.grey),
              ),
              onTap: () async {
                final itemId =
                    controllerTeams.responceTeamActivityDetails[index].id;
                final itemIdInt = itemId!.toInt();
                final flag =
                    controllerTeams.responceTeamActivityDetails[index].flag;
                controllerTeams.isDataLoaded.value = false;

                await controllerTeams
                    .getManagerDashData({'id': itemIdInt, 'flag': flag});
                controllerTeams.isDataLoaded.value = true;
              });
        },
      );
    });
  }
}
