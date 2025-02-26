import 'package:get/get.dart';
import '../controller/dsr_activity_controller.dart';

class DsrActivityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DsrActivityController>(() => DsrActivityController());
  }
}
