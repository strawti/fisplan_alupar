import 'package:fisplan_alupar/app/infra/providers/companies/tension_levels/companies_tension_level_provider.dart';
import 'package:fisplan_alupar/app/infra/providers/equipments/equipments_categories_provider.dart';
import 'package:fisplan_alupar/app/infra/providers/installations/installations_provider.dart';
import 'package:fisplan_alupar/app/infra/providers/installations/installations_type_provider.dart';
import 'package:fisplan_alupar/app/infra/providers/local/companies/projects/local_companies_projects_provider.dart';
import 'package:fisplan_alupar/app/infra/providers/local/companies/tension_levels/local_companies_tension_levels_provider.dart';
import 'package:fisplan_alupar/app/infra/providers/local/equipments/local_equipments_categories_provider.dart';
import 'package:fisplan_alupar/app/infra/providers/local/installations/local_installations_provider.dart';
import 'package:fisplan_alupar/app/infra/providers/local/installations/local_installations_type_provider.dart';
import 'package:fisplan_alupar/app/infra/providers/local/local_towers_provider.dart';
import 'package:fisplan_alupar/app/infra/providers/towers_provider.dart';
import 'package:fisplan_alupar/app/infra/repositories/companies/tension_levels/companies_tension_levels_repository.dart';
import 'package:fisplan_alupar/app/infra/repositories/equipments/equipment_category_repository.dart';
import 'package:fisplan_alupar/app/infra/repositories/installations/installations_repository.dart';
import 'package:fisplan_alupar/app/infra/repositories/installations/installations_type_repository.dart';
import 'package:fisplan_alupar/app/infra/repositories/local/companies/projects/local_companies_projects_repository.dart';
import 'package:fisplan_alupar/app/infra/repositories/local/companies/tension_levels/local_companies_tension_levels_repository.dart';
import 'package:fisplan_alupar/app/infra/repositories/local/equipments/local_equipments_categories_repository.dart';
import 'package:fisplan_alupar/app/infra/repositories/local/installations/local_installations_repository.dart';
import 'package:fisplan_alupar/app/infra/repositories/local/installations/local_installations_type_repository.dart';
import 'package:fisplan_alupar/app/infra/repositories/local/local_towers_repository.dart';
import 'package:fisplan_alupar/app/infra/repositories/towers/towers_repository.dart';
import 'package:fisplan_alupar/app/presenter/new_inspection/controllers/companies_controller.dart';
import 'package:fisplan_alupar/app/presenter/new_inspection/controllers/equipments_categories_controller.dart';
import 'package:fisplan_alupar/app/presenter/new_inspection/controllers/installations_controller.dart';
import 'package:fisplan_alupar/app/presenter/new_inspection/controllers/towers_controller.dart';
import 'package:get/get.dart';

import './new_inspection_controller.dart';
import 'controllers/installation_type_controller.dart';

class NewInspectionBindings implements Bindings {
  @override
  void dependencies() {
    // LOCALS
    Get.lazyPut(() => LocalTowersRepository(Get.find()));
    Get.lazyPut(() => LocalTowersProvider(Get.find()));

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

    // Externals
    Get.lazyPut(() => InstallationsRepository(Get.find()));
    Get.lazyPut(() => InstallationsProvider(Get.find()));

    Get.lazyPut(() => InstallationsTypeRepository(Get.find()));
    Get.lazyPut(() => InstallationsTypeProvider(Get.find()));

    Get.lazyPut(() => TowersRepository(Get.find()));
    Get.lazyPut(() => TowersProvider(Get.find()));

    Get.lazyPut(() => EquipmentCategoryRepository(Get.find()));
    Get.lazyPut(() => EquipmentsCategoriesProvider(Get.find()));

    Get.lazyPut(() => CompaniesTensionLevelsRepository(Get.find()));
    Get.lazyPut(() => CompaniesTensionLevelProvider(Get.find()));

    Get.put(InstallationTypeController(Get.find(), Get.find()));
    Get.put(InstallationsController(Get.find(), Get.find()));
    Get.put(TowersController(Get.find(), Get.find()));
    Get.put(EquipmentsCategoriesController(Get.find(), Get.find()));
    Get.put(CompaniesController(Get.find(), Get.find()));

    Get.put(NewInspectionController());
  }
}
