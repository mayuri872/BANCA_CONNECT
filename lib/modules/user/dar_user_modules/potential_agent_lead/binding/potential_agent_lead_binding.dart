import 'package:get/get.dart';

import '../controller/potential_agent_lead_controller.dart';

class PotentialAgentLeadBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PotentialAgentLeadController>(() => PotentialAgentLeadController());
  }
}
