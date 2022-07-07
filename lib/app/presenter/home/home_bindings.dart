import 'package:get/get.dart';

import '../../infra/providers/companies/projects/companies_projects_provider.dart';
import '../../infra/providers/companies/projects/local/local_companies_projects_provider.dart';
import '../../infra/providers/inspections/local_inspections_provider.dart';
import '../../infra/providers/user/local_user_provider.dart';
import '../../infra/providers/user/user_provider.dart';
import '../../infra/repositories/companies/projects/companies_projects_repository.dart';
import '../../infra/repositories/companies/projects/local/local_companies_projects_repository.dart';
import '../../infra/repositories/inspections/local_inspections_repository.dart';
import '../../infra/repositories/user/local_user_repository.dart';
import '../../infra/repositories/user/user_repository.dart';
import 'home_controller.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LocalUserRepository(Get.find()));
    Get.lazyPut(() => LocalUserProvider(Get.find()));

    Get.lazyPut(() => UserRepository(Get.find()));
    Get.lazyPut(() => UserProvider(Get.find()));

    Get.lazyPut(() => CompaniesProjectsRepository(Get.find()));
    Get.lazyPut(() => CompaniesProjectsProvider(Get.find()));

    Get.lazyPut(() => LocalCompaniesProjectsRepository(Get.find()));
    Get.lazyPut(() => LocalCompaniesProjectsProvider(Get.find()));

    Get.lazyPut(() => LocalInspectionsRepository(Get.find()));
    Get.lazyPut(() => LocalInspectionsProvider(Get.find()));

    Get.put(HomeController(
      Get.find(),
      Get.find(),
      Get.find(),
      Get.find(),
      Get.find(),
    ));
  }
}
