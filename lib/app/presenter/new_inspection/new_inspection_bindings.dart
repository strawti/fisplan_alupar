import 'package:fisplan_alupar/app/infra/providers/local/local_installations_type_provider.dart';
import 'package:fisplan_alupar/app/infra/repositories/installations/installations_type_repository.dart';
import 'package:fisplan_alupar/app/infra/repositories/local/installations/local_installations_type_repository.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import './new_inspection_controller.dart';
import 'controllers/installation_type_controller.dart';

class NewInspectionBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InstallationsTypeRepository(Get.find()));

    Get.lazyPut(() => LocalInstallationsTypeRepository(GetStorage()));

    Get.lazyPut(() => LocalInstallationsTypeProvider(Get.find()));

    Get.put(NewInspectionController());
    Get.lazyPut(() => InstallationTypeController(Get.find(), Get.find()));
  }
}
