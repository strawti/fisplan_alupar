import 'package:get/get.dart';

import '../../core/app_connectivity.dart';
import '../../infra/models/responses/equipment_model.dart';
import '../../infra/providers/equipments/equipments_provider.dart';
import '../../infra/providers/equipments/local/local_equipments_provider.dart';
import '../utils/custom_snackbar.dart';
import '../utils/get_datetime.dart';
import '../utils/loader_manager.dart';

class EquipmentsController extends GetxController with LoaderManager {
  final EquipmentsProvider _installationsProvider;
  final LocalEquipmentsProvider _localEquipmentsProvider;

  EquipmentsController(
    this._installationsProvider,
    this._localEquipmentsProvider,
  );

  @override
  void onReady() {
    super.onReady();
    fetch();
  }

  List<EquipmentModel> _equipments = [];
  List<EquipmentModel> equipmentsFiltered = [];

  Future<void> fetch({bool online = false}) async {
    setIsLoading(true);

    await _getLocal();
    equipmentsFiltered = _equipments.toList();

    if (await AppConnectivity.instance.isConnected()) {
      if (_equipments.isEmpty || online) {
        await _getAll();
      }
    }

    equipmentsFiltered = _equipments.toList();
    _getLastTimeUpdated();

    setIsLoading(false);
  }

  void filterEquipments(
      int categoriesId, int installationId, int tensionLevelId) {
    equipmentsFiltered = _equipments.where((e) {
      return e.equipmentCategoryId == categoriesId &&
          e.installationId == installationId &&
          e.tensionLevelId == tensionLevelId;
    }).toList();

    update();
  }

  Future _getAll() async {
    final response = await _installationsProvider.getAll();

    if (response.isSuccess) {
      _equipments = response.data ?? [];
      _setLocal(_equipments);
    } else {
      CustomSnackbar.to.show(response.error!.content!);
    }
  }

  Future _getLocal() async {
    final response = await _localEquipmentsProvider.getAll();

    if (response.isSuccess) {
      _equipments = response.data ?? [];
    } else {
      CustomSnackbar.to.show(response.error!.content!);
    }
  }

  Future _setLocal(List<EquipmentModel> data) async {
    final response = await _localEquipmentsProvider.setEquipments(
      data,
    );

    if (response.isSuccess) {
      _equipments = data;
    } else {
      CustomSnackbar.to.show(response.error!.content!);
    }
  }

  String lastUpdate = "";
  Future _getLastTimeUpdated() async {
    final response = await _localEquipmentsProvider.getLastTimeUpdated();

    if (response.isSuccess) {
      lastUpdate = formatDateTimeForString(response.data!);
    }
  }
}
