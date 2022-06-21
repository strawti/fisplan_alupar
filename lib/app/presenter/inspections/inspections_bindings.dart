import 'package:fisplan_alupar/app/infra/providers/inspections/inspections_provider.dart';
import 'package:fisplan_alupar/app/infra/providers/towers_provider.dart';
import 'package:fisplan_alupar/app/infra/repositories/inspections/inspections_repository.dart';
import 'package:fisplan_alupar/app/infra/repositories/local/inspections/local_inspections_repository.dart';
import 'package:fisplan_alupar/app/infra/repositories/local/local_towers_repository.dart';
import 'package:fisplan_alupar/app/infra/repositories/towers/towers_repository.dart';
import 'package:get/get.dart';

import './inspections_controller.dart';
import '../../infra/providers/local/inspections/local_inspections_provider.dart';
import '../../infra/providers/local/local_towers_provider.dart';
import '../new_inspection/controllers/towers_controller.dart';

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
