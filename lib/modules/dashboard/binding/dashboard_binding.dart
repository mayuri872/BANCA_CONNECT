import 'package:dsr_clone/modules/dashboard/controller/dashboard_controller.dart';
import 'package:get/get.dart';

class DashboardBinding extends Bindings{
  @override
  void dependencies() {
   Get.lazyPut<DashboardController>(()=>DashboardController());
  }
}