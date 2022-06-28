import 'package:fisplan_alupar/app/infra/providers/installations/installations_provider.dart';
import 'package:fisplan_alupar/app/infra/providers/installations/local/local_installations_provider.dart';
import 'package:fisplan_alupar/app/infra/repositories/installations/installations_repository.dart';
import 'package:fisplan_alupar/app/infra/repositories/installations/local/local_installations_repository.dart';
import 'package:fisplan_alupar/app/presenter/new_inspection/controllers/installations_controller.dart';
import 'package:get/get.dart';

import '../new_inspection/controllers/audios_controller.dart';
import '../new_inspection/controllers/images_controller.dart';
import 'details_inspection_controller.dart';

class DetailsInspectionBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AudiosController());
    Get.lazyPut(() => ImagesController());

    Get.lazyPut(() => LocalInstallationsRepository(Get.find()));
    Get.lazyPut(() => LocalInstallationsProvider(Get.find()));

    Get.lazyPut(() => InstallationsRepository(Get.find()));
    Get.lazyPut(() => InstallationsProvider(Get.find()));

    Get.put(InstallationsController(Get.find(), Get.find()));
    Get.put(DetailsInspectionController());
  }
}
