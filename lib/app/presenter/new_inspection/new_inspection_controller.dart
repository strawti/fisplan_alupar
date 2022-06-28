import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../infra/models/defaults/item_selection_model.dart';
import '../../infra/models/responses/equipment_category_model.dart';
import '../../infra/models/responses/equipment_model.dart';
import '../../infra/models/responses/installation_model.dart';
import '../../infra/models/responses/installation_type_model.dart';
import '../../infra/models/responses/tension_level_model.dart';
import '../../infra/models/responses/tower_model.dart';
import '../../routes/arguments/new_inspection_page_arguments.dart';
import '../../routes/arguments/selection_page_arguments.dart';
import '../../shared/utils/custom_snackbar.dart';
import '../inspections/inspections_controller.dart';
import '../selection_page/selection_page.dart';
import 'controllers/companies_controller.dart';
import 'controllers/equipments_categories_controller.dart';
import 'controllers/equipments_controller.dart';
import 'controllers/installation_type_controller.dart';
import 'controllers/installations_controller.dart';
import 'controllers/towers_controller.dart';

class NewInspectionController extends GetxController {
  NewInspectionController() {
    assert(
      Get.arguments is NewInspectionPageArguments,
      "Passe NewInspectionPageArguments nos argumentos da rota",
    );

    arguments = Get.arguments;
  }

  @override
  void onReady() {
    super.onReady();

    _getPosition();
  }

  @override
  void onClose() {
    super.onClose();

    positionStream?.cancel();
  }

  StreamSubscription<Position>? positionStream;
  Position? position;

  Future _getPosition() async {
    final permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      Geolocator.getPositionStream().listen((pos) {
        position = pos;
        update();
      });
    } else {
      await Geolocator.requestPermission();
      CustomSnackbar.to.show("Permissão de localização negada");
    }
  }

  late NewInspectionPageArguments arguments;

  final instalationTypeController = Get.find<InstallationTypeController>();
  final installationsController = Get.find<InstallationsController>();
  final towersController = Get.find<TowersController>();
  final companiesController = Get.find<CompaniesController>();
  final equipmentController = Get.find<EquipmentsController>();
  final inspectionsController = Get.find<InspectionsController>();

  final equipmentsCategoryController =
      Get.find<EquipmentsCategoriesController>();

  InstallationTypeModel? selectedInstallationType;
  Future getInstallationType() async {
    final ItemSelectionModel<dynamic>? result = await goToSelectionPage(
      'Selecione o tipo de instalação',
      instalationTypeController.installationTypesFiltered,
      selectedInstallationType,
    );

    if (result != null) {
      selectedInstallationType = result.item;
      selectedInstallation = null;
      update();
    }
  }

  InstallationModel? selectedInstallation;
  Future getInstallation() async {
    installationsController.filterByInstallationTypeId(
        selectedInstallationType!.id,
        inspectionsController.routeArguments!.project.id);

    final ItemSelectionModel<dynamic>? result = await goToSelectionPage(
      'Instalação',
      installationsController.installationsFiltered,
      selectedInstallation,
    );

    if (result != null) {
      selectedInstallation = result.item;
      clearSelectedItems();
      update();
    }
  }

  TowerModel? selectedTower;
  Future getTowers() async {
    towersController.filterTowersByInstallation(selectedInstallation!.id);

    final ItemSelectionModel<dynamic>? result = await goToSelectionPage(
      'Torre',
      towersController.towersFiltered,
      selectedTower,
    );

    if (result != null) {
      selectedTower = result.item;
      update();
    }
  }

  EquipmentCategoryModel? selectedEquipmentsCategory;
  Future getEquipmentsCategory() async {
    equipmentsCategoryController
        .filterCategoriesByInstallationId(selectedInstallation!.id);
    final ItemSelectionModel<dynamic>? result = await goToSelectionPage(
      'Categoria do equipamento',
      equipmentsCategoryController.equipmentsCategoriesFiltered,
      selectedEquipmentsCategory,
    );

    if (result != null) {
      selectedEquipmentsCategory = result.item;
      selectedTensionLevel = null;
      update();
    }
  }

  TensionLevelModel? selectedTensionLevel;
  Future getTensionLevel() async {
    final ItemSelectionModel<dynamic>? result = await goToSelectionPage(
      'Nível de tensão',
      companiesController.tensionLevelsFiltered,
      selectedTensionLevel,
    );

    if (result != null) {
      selectedTensionLevel = result.item;
      update();
    }
  }

  EquipmentModel? selectedEquipment;
  Future getEquipments() async {
    equipmentController.filterEquipments(selectedEquipmentsCategory!.id,
        selectedInstallation!.id, selectedTensionLevel!.id);
    final ItemSelectionModel<dynamic>? result = await goToSelectionPage(
      'Equipamento',
      equipmentController.equipmentsFiltered,
      selectedEquipment,
    );

    if (result != null) {
      selectedEquipment = result.item;
      update();
    }
  }

  void clearSelectedItems() {
    selectedTower = null;
    selectedEquipmentsCategory = null;
    selectedTensionLevel = null;
  }

  Future goToSelectionPage(String title, List data, dynamic item) async {
    return await Get.toNamed(
      SelectionPage.route,
      arguments: SelectionPageArguments(
        title: title,
        items: data.map(
          (e) {
            return ItemSelectionModel(
              title: e.name,
              item: e,
              isChecked: item == e,
            );
          },
        ).toList(),
      ),
    );
  }
}
