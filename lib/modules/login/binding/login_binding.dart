import 'package:get/get.dart';

import '../../../data/network/common_providers/login_network_provider.dart';
import '../../../data/services/common_servces/login_service.dart';
import '../controller/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    // Ensure LoginNetworkProvider is instantiated first
    Get.put(LoginNetworkProvider());
    // Instantiate LoginService with the required dependency
    Get.put(LoginService(Get.find<LoginNetworkProvider>()));
    // Instantiate LoginController with the required dependency
    Get.put(LoginController(Get.find<LoginService>()));
  }
}