import 'package:dsr_clone/modules/manger/dar_manager_modules/manger_dashboard/controller/manager_dashboard_controller.dart';
import 'package:get/get.dart';

class ManagerDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManagerDashboardController>(() => ManagerDashboardController());
  }
}