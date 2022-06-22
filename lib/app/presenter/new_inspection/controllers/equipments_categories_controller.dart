import 'package:get/get.dart';

import '../../../core/app_connectivity.dart';
import '../../../infra/models/responses/equipment_category_model.dart';
import '../../../infra/providers/equipments/equipments_categories_provider.dart';
import '../../../infra/providers/equipments/local/local_equipments_categories_provider.dart';
import '../../../shared/utils/custom_snackbar.dart';
import '../../../shared/utils/loader_manager.dart';

class EquipmentsCategoriesController extends GetxController with LoaderManager {
  static EquipmentsCategoriesController get to => Get.find();

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
      if (_equipmentsCategories.isEmpty || online) {
        await _getAll();
      }
    }

    equipmentsCategoriesFiltered = _equipmentsCategories.toList();

    setIsLoading(false);
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
}
