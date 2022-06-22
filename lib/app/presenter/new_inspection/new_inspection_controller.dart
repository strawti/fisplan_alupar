import 'package:fisplan_alupar/app/infra/models/defaults/item_selection_model.dart';
import 'package:fisplan_alupar/app/infra/models/equipment_category_model.dart';
import 'package:fisplan_alupar/app/infra/models/installation_model.dart';
import 'package:fisplan_alupar/app/infra/models/installation_type_model.dart';
import 'package:fisplan_alupar/app/infra/models/tower_model.dart';
import 'package:fisplan_alupar/app/presenter/new_inspection/controllers/companies_controller.dart';
import 'package:fisplan_alupar/app/presenter/new_inspection/controllers/equipments_categories_controller.dart';
import 'package:fisplan_alupar/app/presenter/new_inspection/controllers/installation_type_controller.dart';
import 'package:fisplan_alupar/app/presenter/new_inspection/controllers/installations_controller.dart';
import 'package:fisplan_alupar/app/presenter/new_inspection/controllers/towers_controller.dart';
import 'package:fisplan_alupar/app/presenter/selection_page/selection_page.dart';
import 'package:fisplan_alupar/app/routes/arguments/selection_page_arguments.dart';
import 'package:get/get.dart';

class NewInspectionController extends GetxController {
  final instalationTypeController = Get.find<InstallationTypeController>();
  final installationsController = Get.find<InstallationsController>();
  final towersController = Get.find<TowersController>();
  final companiesController = Get.find<CompaniesController>();

  final equipmentsCategoryController =
      Get.find<EquipmentsCategoriesController>();

  InstallationTypeModel? selectedInstallationType;
  Future getInstallationType() async {
    final ItemSelectionModel<dynamic>? result = await goToSelectionPage(
      'Selecione o tipo de instalação',
      instalationTypeController.installationTypes,
    );

    if (result != null) {
      selectedInstallationType = result.item;
      selectedInstallation = null;
      update();
    }
  }

  InstallationModel? selectedInstallation;
  Future getInstallation() async {
    await installationsController.fetch(selectedInstallationType!.id);

    final ItemSelectionModel<dynamic>? result = await goToSelectionPage(
      'Instalação',
      installationsController.installations,
    );

    if (result != null) {
      selectedInstallation = result.item;
      clearSelectedItems();
      update();
    }
  }

  TowerModel? selectedTower;
  Future getTowers() async {
    await towersController.fetch();

    final ItemSelectionModel<dynamic>? result = await goToSelectionPage(
      'Torre',
      towersController.towers,
    );

    if (result != null) {
      selectedTower = result.item;
      update();
    }
  }

  EquipmentCategoryModel? selectedEquipmentsCategory;
  Future getEquipmentsCategory() async {
    await equipmentsCategoryController.fetch();

    final ItemSelectionModel<dynamic>? result = await goToSelectionPage(
      'Categoria do equipamento',
      equipmentsCategoryController.equipmentsCategories,
    );

    if (result != null) {
      selectedEquipmentsCategory = result.item;
      update();
    }
  }

  EquipmentCategoryModel? selectedTensionLevel;
  Future getTensionLevel(int id) async {
    await companiesController.fetch(id);

    final ItemSelectionModel<dynamic>? result = await goToSelectionPage(
      'Nível de tensão',
      companiesController.tensionLevels,
    );

    if (result != null) {
      selectedTensionLevel = result.item;
      update();
    }
  }

  void clearSelectedItems() {
    selectedTower = null;
    selectedEquipmentsCategory = null;
    selectedTensionLevel = null;
  }

  Future goToSelectionPage(String title, List data) async {
    return await Get.toNamed(
      SelectionPage.route,
      arguments: SelectionPageArguments(
        title: title,
        items: data.map(
          (e) {
            return ItemSelectionModel(
              title: e.name,
              item: e,
            );
          },
        ).toList(),
      ),
    );
  }
}
