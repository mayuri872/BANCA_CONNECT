import 'package:get/get.dart';
import '../controller/dar_activity_controller.dart';

class DarActivityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DarActivityController>(() => DarActivityController());
  }
}
