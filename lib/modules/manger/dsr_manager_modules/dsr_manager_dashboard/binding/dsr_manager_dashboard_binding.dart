
import 'package:get/get.dart';

import '../controller/dsr_manager_dashboard_controller.dart';

class DSRManagerDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DSRManagerDashboardController>(() => DSRManagerDashboardController());
  }
}