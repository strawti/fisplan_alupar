import 'package:fisplan_alupar/app/infra/providers/installations/installations_type_provider.dart';
import 'package:fisplan_alupar/app/infra/providers/local/installations/local_installations_type_provider.dart';
import 'package:fisplan_alupar/app/infra/providers/local/local_towers_provider.dart';
import 'package:fisplan_alupar/app/infra/providers/towers_provider.dart';
import 'package:fisplan_alupar/app/infra/repositories/installations/installations_type_repository.dart';
import 'package:fisplan_alupar/app/infra/repositories/local/installations/local_installations_type_repository.dart';
import 'package:fisplan_alupar/app/infra/repositories/local/local_towers_repository.dart';
import 'package:fisplan_alupar/app/infra/repositories/towers/towers_repository.dart';
import 'package:fisplan_alupar/app/presenter/new_inspection/controllers/towers_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import './new_inspection_controller.dart';
import 'controllers/installation_type_controller.dart';

class NewInspectionBindings implements Bindings {
  @override
  void dependencies() {
    // Local
    Get.lazyPut(() => LocalTowersRepository(GetStorage()));
    Get.lazyPut(() => LocalInstallationsTypeRepository(GetStorage()));

    Get.lazyPut(() => LocalInstallationsTypeProvider(Get.find()));
    Get.lazyPut(() => LocalTowersProvider(Get.find()));

    // External
    Get.lazyPut(() => InstallationsTypeRepository(Get.find()));
    Get.lazyPut(() => TowersRepository(Get.find()));

    Get.lazyPut(() => InstallationsTypeProvider(Get.find()));
    Get.lazyPut(() => TowersProvider(Get.find()));

    Get.put(NewInspectionController());
    Get.put(InstallationTypeController(Get.find(), Get.find()));
    Get.put(TowersController(Get.find(), Get.find()));
  }
}
