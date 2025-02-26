import 'package:get/get.dart';
import '../../../shared/routes/app_routes.dart';
import '../../../shared/widget/dialogs.dart';

class AppController extends GetxController {
  Dialogs dialogs = Dialogs();

  logoutConfirm() {
    dialogs.logoutConfirm(
      'Are you sure want to logout',
      'Are you sure you want to log out from this device?',
    );
  }

  logout() {
    Get.offAllNamed(AppRoutes.login);
    Get.back();
  }
}
