import 'package:fisplan_alupar/app/presenter/home/home_controller.dart';
import 'package:get/get.dart';

import '../inspections/inspections_controller.dart';
import '../../shared/controllers/activities_controller.dart';
import '../../shared/controllers/companies_controller.dart';
import '../../shared/controllers/equipments_categories_controller.dart';
import '../../shared/equipments_controller.dart';
import '../../shared/controllers/installation_type_controller.dart';
import '../../shared/controllers/installations_controller.dart';
import '../../shared/controllers/towers_controller.dart';

class DownloadDataController extends GetxController {
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
}
