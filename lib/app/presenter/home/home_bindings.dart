import 'package:fisplan_alupar/app/infra/providers/auth/user_provider.dart';
import 'package:fisplan_alupar/app/infra/repositories/auth/user_repository.dart';
import 'package:fisplan_alupar/app/infra/repositories/local/local_user_repository.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import './home_controller.dart';
import '../../infra/providers/local/local_user_provider.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LocalUserRepository(GetStorage()));
    Get.lazyPut(() => LocalUserProvider(Get.find()));
    Get.lazyPut(() => UserRepository(Get.find()));
    Get.lazyPut(() => UserProvider(Get.find()));

    Get.put(HomeController());
  }
}
