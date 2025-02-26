

import 'package:get/get.dart';

import '../controller/manager_agentlead_controller.dart';

class ManagerAgentLeadBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManagerAgentLeadController>(() => ManagerAgentLeadController());
  }
}

