import 'package:fisplan_alupar/app/infra/providers/auth/user_provider.dart';
import 'package:fisplan_alupar/app/infra/providers/companies/projects/companies_projects_provider.dart';
import 'package:fisplan_alupar/app/infra/repositories/auth/user_repository.dart';
import 'package:fisplan_alupar/app/infra/repositories/local/companies/projects/local_companies_projects_repository.dart';
import 'package:fisplan_alupar/app/infra/repositories/local/local_user_repository.dart';
import 'package:get/get.dart';

import './home_controller.dart';
import '../../infra/providers/local/companies/projects/local_companies_projects_provider.dart';
import '../../infra/providers/local/local_user_provider.dart';
import '../../infra/repositories/companies/projects/companies_projects_repository.dart';

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

    Get.put(HomeController(
      Get.find(),
      Get.find(),
      Get.find(),
      Get.find(),
    ));
  }
}
