import 'package:get/get.dart';

import '../controller/manager_custlead_controller.dart';

class ManagerCustBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManagerCustLeadController>(() => ManagerCustLeadController());
  }
}
