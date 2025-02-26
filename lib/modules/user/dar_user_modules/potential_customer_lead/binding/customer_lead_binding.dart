import 'package:get/get.dart';

import '../controller/customer_lead_controller.dart';

class CustomerLeadBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerLeadController>(() => CustomerLeadController());
  }
}
