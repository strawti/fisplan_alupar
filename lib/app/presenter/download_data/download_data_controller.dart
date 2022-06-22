import 'package:get/get.dart';

import '../inspections/inspections_controller.dart';
import '../new_inspection/controllers/activities_controller.dart';
import '../new_inspection/controllers/companies_controller.dart';
import '../new_inspection/controllers/equipments_categories_controller.dart';
import '../new_inspection/controllers/equipments_controller.dart';
import '../new_inspection/controllers/installation_type_controller.dart';
import '../new_inspection/controllers/installations_controller.dart';
import '../new_inspection/controllers/towers_controller.dart';

class DownloadDataController extends GetxController {
  bool isLoading() {
    return Get.find<TowersController>().isLoading ||
        Get.find<InstallationTypeController>().isLoading ||
        Get.find<InstallationsController>().isLoading ||
        Get.find<EquipmentsController>().isLoading ||
        Get.find<EquipmentsCategoriesController>().isLoading ||
        Get.find<InspectionsController>().isLoading ||
        Get.find<CompaniesController>().isLoading ||
        Get.find<ActivitiesController>().isLoading;
  }
}
