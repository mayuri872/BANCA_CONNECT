
import 'package:get/get.dart';

import '../controller/lead_report_controller.dart';

class LeadReportBinding extends Bindings{
  @override
  void dependencies() {
   Get.lazyPut<LeadReportController>(()=>LeadReportController());
  }
}