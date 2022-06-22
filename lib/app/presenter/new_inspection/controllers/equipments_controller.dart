import 'package:fisplan_alupar/app/infra/models/responses/equipment_model.dart';
import 'package:fisplan_alupar/app/infra/providers/equipments/equipments_provider.dart';
import 'package:get/get.dart';

import '../../../core/app_connectivity.dart';
import '../../../infra/providers/local/equipments/local_equipments_provider.dart';
import '../../../shared/utils/custom_snackbar.dart';
import '../../../shared/utils/loader_manager.dart';

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
    if (await AppConnectivity.instance.isConnected()) {
      if (_equipments.isEmpty || online) {
        await _getAll();
      }
    }

    equipmentsFiltered = _equipments.toList();

    setIsLoading(false);
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
}
