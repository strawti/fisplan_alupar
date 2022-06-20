import 'package:get/get.dart';

import '../../../core/app_connectivity.dart';
import '../../../infra/models/equipment_category_model.dart';
import '../../../infra/providers/equipments/equipments_categories_provider.dart';
import '../../../infra/providers/local/equipments/local_equipments_categories_provider.dart';
import '../../../shared/utils/custom_snackbar.dart';
import '../../../shared/utils/loader_manager.dart';

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

  List<EquipmentCategoryModel> equipmentsCategories = [];

  Future<void> fetch() async {
    setIsLoading(true);

    if (await AppConnectivity.instance.isConnected()) {
      await _getAll();
    } else {
      await _getLocalAll();
    }

    setIsLoading(false);
  }

  Future _getAll() async {
    final response = await _equipmentsCategoriesProvider.getAll();

    if (response.isSuccess) {
      equipmentsCategories = response.data ?? [];
      _setLocal(equipmentsCategories);
    } else {
      CustomSnackbar.to.show(response.error!.content!);
    }
  }

  Future _getLocalAll() async {
    final response = await _localEquipmentsCategoriesProvider.getAll();

    if (response.isSuccess) {
      equipmentsCategories = response.data ?? [];
    } else {
      CustomSnackbar.to.show(response.error!.content!);
    }
  }

  Future _setLocal(List<EquipmentCategoryModel> data) async {
    final response = await _localEquipmentsCategoriesProvider.set(
      data,
    );

    if (response.isSuccess) {
      equipmentsCategories = data;
    } else {
      CustomSnackbar.to.show(response.error!.content!);
    }
  }
}
