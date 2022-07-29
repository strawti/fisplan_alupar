import 'dart:async';

import 'package:get/get.dart';

import '../../shared/controllers/activities_controller.dart';
import '../../shared/controllers/companies_controller.dart';
import '../../shared/controllers/equipments_categories_controller.dart';
import '../../shared/controllers/equipments_controller.dart';
import '../../shared/controllers/installation_type_controller.dart';
import '../../shared/controllers/installations_controller.dart';
import '../../shared/controllers/towers_controller.dart';
import '../home/home_controller.dart';
import '../inspections/inspections_controller.dart';

class DownloadDataController extends GetxController {
  @override
  void onClose() {
    HomeController.to.getInspectionsUnsynch();
    super.onClose();
  }

  // @override
  // void onReady() async {
  //   super.onReady();

  //   AppConnectivity.instance.isWifi().then((isWifi) {
  //     if (isWifi) {
  //       Get.defaultDialog(
  //         title: 'Você está conectado via Wifi',
  //         middleText: 'Aproveite para sincronizar os dados!',
  //         barrierDismissible: true,
  //       );
  //     }
  //   });
  // }

  bool isLoading() {
    return Get.find<TowersController>().isLoading ||
        Get.find<InstallationTypeController>().isLoading ||
        Get.find<InstallationsController>().isLoading ||
        Get.find<EquipmentsController>().isLoading ||
        Get.find<EquipmentsCategoriesController>().isLoading ||
        Get.find<InspectionsController>().isLoading ||
        Get.find<CompaniesTensionLevelController>().isLoading ||
        Get.find<ActivitiesController>().isLoading ||
        Get.find<HomeController>().isLoading;
  }

  Future syncAll() async {
    if (isLoading() == false) {
      if (Get.find<InspectionsController>()
          .inspectionsUnsynchronized
          .isNotEmpty) {
        await Get.find<InspectionsController>().syncInspections();
        return;
      }

      scheduleMicrotask(() {
        Future.wait([
          Get.find<InspectionsController>().fetch(online: true),
          Get.find<TowersController>().fetch(online: true),
        ]);
      });

      scheduleMicrotask(() {
        Future.wait([
          Get.find<InstallationTypeController>().fetch(online: true),
          Get.find<InstallationsController>().fetch(online: true),
        ]);
      });

      scheduleMicrotask(() {
        Future.wait([
          Get.find<EquipmentsController>().fetch(online: true),
          Get.find<EquipmentsCategoriesController>().fetch(online: true),
        ]);
      });

      scheduleMicrotask(() {
        Future.wait([
          Get.find<CompaniesTensionLevelController>().fetch(online: true),
          Get.find<ActivitiesController>().fetch(online: true),
          Get.find<HomeController>().fetch(online: true),
        ]);
      });
    }
  }
}
