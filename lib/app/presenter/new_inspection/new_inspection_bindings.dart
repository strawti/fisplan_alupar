import 'package:fisplan_alupar/app/infra/providers/inspections/local_inspections_provider.dart';
import 'package:fisplan_alupar/app/infra/repositories/activities/activity_repository.dart';
import 'package:fisplan_alupar/app/infra/repositories/activities/local_activities_repository.dart';
import 'package:fisplan_alupar/app/infra/repositories/companies/projects/companies_projects_questionnaires_repository.dart';
import 'package:fisplan_alupar/app/infra/repositories/companies/projects/companies_projects_steps_repository.dart';
import 'package:fisplan_alupar/app/infra/repositories/companies/projects/local/local_companies_projects_questionnaires_repository.dart';
import 'package:fisplan_alupar/app/infra/repositories/companies/projects/local/local_companies_projects_steps_repository.dart';
import 'package:fisplan_alupar/app/presenter/new_inspection/controllers/questionnaires_controller.dart';
import 'package:get/get.dart';

import '../../infra/providers/activities/activities_provider.dart';
import '../../infra/providers/activities/local_activities_provider.dart';
import '../../infra/providers/companies/projects/companies_projects_questionnaires_provider.dart';
import '../../infra/providers/companies/projects/companies_projects_steps_provider.dart';
import '../../infra/providers/companies/projects/local/local_companies_projects_provider.dart';
import '../../infra/providers/companies/projects/local/local_companies_projects_questionnaires_provider.dart';
import '../../infra/providers/companies/projects/local/local_companies_projects_steps_provider.dart';
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
import '../../infra/repositories/installations/installations_repository.dart';
import '../../infra/repositories/installations/installations_type_repository.dart';
import '../../infra/repositories/installations/local/local_installations_repository.dart';
import '../../infra/repositories/installations/local/local_installations_type_repository.dart';
import '../../infra/repositories/towers/local_towers_repository.dart';
import '../../infra/repositories/towers/towers_repository.dart';
import 'controllers/activities_controller.dart';
import 'controllers/audios_controller.dart';
import 'controllers/companies_controller.dart';
import 'controllers/equipments_categories_controller.dart';
import 'controllers/equipments_controller.dart';
import 'controllers/images_controller.dart';
import 'controllers/installation_type_controller.dart';
import 'controllers/installations_controller.dart';
import 'controllers/steps_controller.dart';
import 'controllers/towers_controller.dart';
import 'new_inspection_controller.dart';

class NewInspectionBindings implements Bindings {
  @override
  void dependencies() {
    // LOCALS
    Get.lazyPut(() => LocalInstallationsRepository(Get.find()));
    Get.lazyPut(() => LocalInspectionsProvider(Get.find()));

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

    Get.lazyPut(() => LocalEquipmentsProvider(Get.find()));
    Get.lazyPut(() => LocalEquipmentsRepository(Get.find()));

    Get.lazyPut(() => LocalActivitiesRepository(Get.find()));
    Get.lazyPut(() => LocalActivitiesProvider(Get.find()));

    Get.lazyPut(
      () => LocalCompaniesProjectsQustionnairesRepository(Get.find()),
    );

    Get.lazyPut(
      () => LocalCompaniesProjectsQuestionnairesProvider(Get.find()),
    );

    Get.lazyPut(() => LocalCompaniesProjectsStepsRepository(Get.find()));
    Get.lazyPut(() => LocalCompaniesProjectsStepsProvider(Get.find()));

    // Externals
    Get.lazyPut(() => InstallationsRepository(Get.find()));
    Get.lazyPut(() => InstallationsProvider(Get.find()));

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

    Get.lazyPut(() => CompaniesProjectsQuestionnairesRepository(Get.find()));
    Get.lazyPut(() => CompaniesProjectsQuestionnairesProvider(Get.find()));

    Get.lazyPut(() => CompaniesProjectsStepsRepository(Get.find()));
    Get.lazyPut(() => CompaniesProjectsStepsProvider(Get.find()));

    Get.lazyPut(() => ActivitiesRepository(Get.find()));
    Get.lazyPut(() => ActivitiesProvider(Get.find()));

    Get.lazyPut(() => AudiosController());
    Get.lazyPut(() => ImagesController());
    Get.put(InstallationTypeController(Get.find(), Get.find()));
    Get.put(InstallationsController(Get.find(), Get.find()));
    Get.put(TowersController(Get.find(), Get.find()));
    Get.lazyPut(() => EquipmentsController(Get.find(), Get.find()));
    Get.put(EquipmentsCategoriesController(Get.find(), Get.find()));
    Get.put(CompaniesTensionLevelController(Get.find(), Get.find()));
    Get.put(QuestionnairesController(Get.find(), Get.find()));
    Get.put(StepsController(Get.find(), Get.find()));
    Get.put(ActivitiesController(Get.find(), Get.find()));

    Get.put(NewInspectionController(Get.find()));
  }
}
