import 'package:get/get.dart';

import '../../core/app_connectivity.dart';
import '../../infra/models/responses/equipment_category_model.dart';
import '../../infra/providers/equipments/equipments_categories_provider.dart';
import '../../infra/providers/equipments/local/local_equipments_categories_provider.dart';
import '../utils/custom_snackbar.dart';
import '../utils/get_datetime.dart';
import '../utils/loader_manager.dart';

class EquipmentsCategoriesController extends GetxController with LoaderManager {
  final EquipmentsCategoriesProvider _equipmentsCategoriesProvider;
  final LocalEquipmentsCategoriesProvider _localEquipmentsCategoriesProvider;

  EquipmentsCategoriesController(
    this._equipmentsCategoriesProvider,
    this._localEquipmentsCategoriesProvider,
  );

  @override
  void onReady() {
    super.onReady();
    fetch();
  }

  List<EquipmentCategoryModel> _equipmentsCategories = [];
  List<EquipmentCategoryModel> equipmentsCategoriesFiltered = [];

  Future<void> fetch({bool online = false}) async {
    setIsLoading(true);

    await _getLocalAll();
    if (await AppConnectivity.instance.isConnected()) {
      final isWifi = await AppConnectivity.instance.isWifi();
      if (_equipmentsCategories.isEmpty || online || isWifi) {
        await _getAll();
      }
    }

    equipmentsCategoriesFiltered = _equipmentsCategories.toList();
    _getLastTimeUpdated();

    setIsLoading(false);
  }

  void filterCategoriesByInstallationId(int installationId) {
    equipmentsCategoriesFiltered = _equipmentsCategories.where((e) {
      return e.installationId == installationId;
    }).toList();

    update();
  }

  Future _getAll() async {
    final response = await _equipmentsCategoriesProvider.getAll();

    if (response.isSuccess) {
      _equipmentsCategories = response.data ?? [];
      _setLocal(_equipmentsCategories);
    } else {
      CustomSnackbar.to.show(response.error!.content!);
    }
  }

  Future _getLocalAll() async {
    final response = await _localEquipmentsCategoriesProvider.getAll();

    if (response.isSuccess) {
      _equipmentsCategories = response.data ?? [];
    } else {
      CustomSnackbar.to.show(response.error!.content!);
    }
  }

  Future _setLocal(List<EquipmentCategoryModel> data) async {
    final response = await _localEquipmentsCategoriesProvider.set(
      data,
    );

    if (response.isSuccess) {
      _equipmentsCategories = data;
    } else {
      CustomSnackbar.to.show(response.error!.content!);
    }
  }

  String lastUpdate = "";
  Future _getLastTimeUpdated() async {
    final response =
        await _localEquipmentsCategoriesProvider.getLastTimeUpdated();

    if (response.isSuccess) {
      lastUpdate = formatDateTimeForString(response.data!);
    }
  }
}
