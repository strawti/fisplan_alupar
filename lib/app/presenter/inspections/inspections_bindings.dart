import '../../infra/providers/inspections/inspections_provider.dart';
import '../../infra/providers/towers/towers_provider.dart';
import '../../infra/repositories/inspections/inspections_repository.dart';
import '../../infra/repositories/inspections/local_inspections_repository.dart';
import '../../infra/repositories/towers/local_towers_repository.dart';
import '../../infra/repositories/towers/towers_repository.dart';
import 'package:get/get.dart';

import 'inspections_controller.dart';
import '../../infra/providers/inspections/local_inspections_provider.dart';
import '../../infra/providers/towers/local_towers_provider.dart';
import '../../shared/controllers/towers_controller.dart';

class InspectionsBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InspectionsRepository(Get.find()));
    Get.lazyPut(() => InspectionsProvider(Get.find()));

    Get.lazyPut(() => LocalInspectionsRepository(Get.find()));
    Get.lazyPut(() => LocalInspectionsProvider(Get.find()));

    Get.lazyPut(() => TowersRepository(Get.find()));
    Get.lazyPut(() => TowersProvider(Get.find()));

    Get.lazyPut(() => LocalTowersRepository(Get.find()));
    Get.lazyPut(() => LocalTowersProvider(Get.find()));

    Get.put(TowersController(
      Get.find(),
      Get.find(),
    ));

    Get.put(InspectionsController(
      Get.find(),
      Get.find(),
    ));
  }
}
