import 'package:get/get.dart';

import '../../../infra/providers/auth/login_provider.dart';
import '../../../infra/repositories/auth/login_repository.dart';
import 'login_controller.dart';

class LoginBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginRepository(Get.find()));
    Get.lazyPut(() => LoginProvider(Get.find()));
    Get.put(LoginController(Get.find()));
  }
}
