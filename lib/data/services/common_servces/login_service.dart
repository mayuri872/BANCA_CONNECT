import 'package:dsr_clone/data/models/login/login_model.dart';
import 'package:dsr_clone/data/models/login/response_login.dart';
import 'package:dsr_clone/data/network/common_providers/login_network_provider.dart';
import 'package:get/get.dart';

import '../../../modules/login/controller/login_controller.dart';

class LoginService extends GetConnect {
  final LoginNetworkProvider loginNetworkProvider =
      Get.put(LoginNetworkProvider());

  LoginService(LoginNetworkProvider find);
  Future<dynamic> doLogin({
    required RequestLogin body,
    required Function(ResponseLogin resMember) onSuccess,
    required Function(String? error) onFailed,
  }) async {
    await loginNetworkProvider.userLogin(
      body: body,
      userType: Get.find<LoginController>().selectedValue.value,
      onSuccess: (loginRes, requestLogin) async {
        onSuccess(loginRes);
        return;
      },
      onFailed: (error) {
        onFailed(error);
        return;
      },
    );
  }
}
