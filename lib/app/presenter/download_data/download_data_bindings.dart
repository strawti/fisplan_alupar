import 'package:fisplan_alupar/app/infra/providers/activities/activities_provider.dart';
import 'package:fisplan_alupar/app/infra/providers/activities/local_activities_provider.dart';
import 'package:fisplan_alupar/app/infra/providers/inspections/inspections_provider.dart';
import 'package:fisplan_alupar/app/infra/providers/inspections/local_inspections_provider.dart';
import 'package:fisplan_alupar/app/infra/repositories/activities/activity_repository.dart';
import 'package:fisplan_alupar/app/infra/repositories/activities/local_activities_repository.dart';
import 'package:fisplan_alupar/app/infra/repositories/inspections/inspections_repository.dart';
import 'package:fisplan_alupar/app/presenter/download_data/download_data_controller.dart';
import 'package:fisplan_alupar/app/presenter/inspections/inspections_controller.dart';
import 'package:fisplan_alupar/app/presenter/new_inspection/controllers/activities_controller.dart';
import 'package:get/get.dart';

import '../../infra/providers/companies/projects/local_companies_projects_provider.dart';
import '../../infra/providers/companies/tension_levels/companies_tension_level_provider.dart';
import '../../infra/providers/companies/tension_levels/local_companies_tension_levels_provider.dart';
import '../../infra/providers/equipments/equipments_categories_provider.dart';
import '../../infra/providers/equipments/equipments_provider.dart';
import '../../infra/providers/equipments/local/local_equipments_categories_provider.dart';
import '../../infra/providers/equipments/local/local_equipments_provider.dart';
import '../../infra/providers/installations/installations_provider.dart';
import '../../infra/providers/installations/installations_type_provider.dart';
import '../../infra/providers/installations/local/local_installations_provider.dart';
import '../../infra/providers/installations/local/local_installations_type_provider.dart';
import '../../infra/providers/towers/local_towers_provider.dart';
import '../../infra/providers/towers/towers_provider.dart';
import '../../infra/repositories/companies/projects/local/local_companies_projects_repository.dart';
import '../../infra/repositories/companies/tension_levels/companies_tension_levels_repository.dart';
import '../../infra/repositories/companies/tension_levels/local_companies_tension_levels_repository.dart';
import '../../infra/repositories/equipments/equipment_category_repository.dart';
import '../../infra/repositories/equipments/equipment_repository.dart';
import '../../infra/repositories/equipments/local/local_equipments_categories_repository.dart';
import '../../infra/repositories/equipments/local/local_equipments_repository.dart';
import '../../infra/repositories/inspections/local_inspections_repository.dart';
import '../../infra/repositories/installations/installations_repository.dart';
import '../../infra/repositories/installations/installations_type_repository.dart';
import '../../infra/repositories/installations/local/local_installations_repository.dart';
import '../../infra/repositories/installations/local/local_installations_type_repository.dart';
import '../../infra/repositories/towers/local_towers_repository.dart';
import '../../infra/repositories/towers/towers_repository.dart';
import '../new_inspection/controllers/companies_controller.dart';
import '../new_inspection/controllers/equipments_categories_controller.dart';
import '../new_inspection/controllers/equipments_controller.dart';
import '../new_inspection/controllers/installation_type_controller.dart';
import '../new_inspection/controllers/installations_controller.dart';
import '../new_inspection/controllers/towers_controller.dart';

class DownloadDataBindings implements Bindings {
  @override
  void dependencies() {
    // LOCALS
    Get.lazyPut(() => LocalTowersRepository(Get.find()));
    Get.lazyPut(() => LocalTowersProvider(Get.find()));

    Get.lazyPut(() => LocalActivitiesRepository(Get.find()));
    Get.lazyPut(() => LocalActivitiesProvider(Get.find()));

    Get.lazyPut(() => LocalInstallationsTypeRepository(Get.find()));
    Get.lazyPut(() => LocalInstallationsTypeProvider(Get.find()));

    Get.lazyPut(() => LocalInstallationsRepository(Get.find()));
    Get.lazyPut(() => LocalInstallationsProvider(Get.find()));

    Get.lazyPut(() => LocalEquipmentsCategoriesRepository(Get.find()));
    Get.lazyPut(() => LocalEquipmentsCategoriesProvider(Get.find()));

    Get.lazyPut(() => LocalCompaniesTensionLevelsRepository(Get.find()));
    Get.lazyPut(() => LocalCompaniesTensionLevelsProvider(Get.find()));

    Get.lazyPut(() => LocalCompaniesProjectsRepository(Get.find()));
    Get.lazyPut(() => LocalCompaniesProjectsProvider(Get.find()));

    Get.lazyPut(() => LocalEquipmentsProvider(Get.find()));
    Get.lazyPut(() => LocalEquipmentsRepository(Get.find()));

    Get.lazyPut(() => LocalInspectionsProvider(Get.find()));
    Get.lazyPut(() => LocalInspectionsRepository(Get.find()));

    // Externals
    Get.lazyPut(() => InstallationsRepository(Get.find()));
    Get.lazyPut(() => InstallationsProvider(Get.find()));

    Get.lazyPut(() => ActivitiesProvider(Get.find()));
    Get.lazyPut(() => ActivitiesRepository(Get.find()));

    Get.lazyPut(() => InstallationsTypeRepository(Get.find()));
    Get.lazyPut(() => InstallationsTypeProvider(Get.find()));

    Get.lazyPut(() => TowersRepository(Get.find()));
    Get.lazyPut(() => TowersProvider(Get.find()));

    Get.lazyPut(() => EquipmentCategoryRepository(Get.find()));
    Get.lazyPut(() => EquipmentsCategoriesProvider(Get.find()));

    Get.lazyPut(() => EquipmentsProvider(Get.find()));
    Get.lazyPut(() => EquipmentRepository(Get.find()));

    Get.lazyPut(() => CompaniesTensionLevelsRepository(Get.find()));
    Get.lazyPut(() => CompaniesTensionLevelProvider(Get.find()));

    Get.lazyPut(() => InspectionsProvider(Get.find()));
    Get.lazyPut(() => InspectionsRepository(Get.find()));

    Get.put(InstallationTypeController(Get.find(), Get.find()));
    Get.put(InstallationsController(Get.find(), Get.find()));
    Get.put(TowersController(Get.find(), Get.find()));
    Get.put(EquipmentsController(Get.find(), Get.find()));
    Get.put(EquipmentsCategoriesController(Get.find(), Get.find()));
    Get.put(CompaniesController(Get.find(), Get.find()));
    Get.put(InspectionsController(Get.find(), Get.find()));
    Get.put(ActivitiesController(Get.find(), Get.find()));

    Get.put(DownloadDataController());
  }
}
