import 'package:get/get.dart';

import '../../core/app_connectivity.dart';
import '../../infra/models/responses/tower_model.dart';
import '../../infra/providers/towers/local_towers_provider.dart';
import '../../infra/providers/towers/towers_provider.dart';
import '../../presenter/new_inspection/new_inspection_controller.dart';
import '../utils/custom_snackbar.dart';
import '../utils/get_datetime.dart';
import '../utils/loader_manager.dart';

class TowersController extends GetxController with LoaderManager {
  final TowersProvider _towersProvider;
  final LocalTowersProvider _localTowersProvider;

  TowersController(
    this._towersProvider,
    this._localTowersProvider,
  );

  @override
  void onReady() {
    super.onReady();
    fetch();
  }

  List<TowerModel> _towers = [];
  List<TowerModel> towersFiltered = [];

  Future<void> fetch({bool online = false}) async {
    setIsLoading(true);

    await _getLocal();
    towersFiltered = _towers.toList();

    if (await AppConnectivity.instance.isConnected()) {
      final isWifi = await AppConnectivity.instance.isWifi();
      if (_towers.isEmpty || online || isWifi) {
        await _getAll();
        _getLastTimeUpdated();
      }
    }

    towersFiltered = _towers.toList();

    setIsLoading(false);
  }

  Future _getAll() async {
    final response = await _towersProvider.getAll();

    if (response.isSuccess) {
      _towers = response.data ?? [];
      _setLocal(_towers);
    } else {
      CustomSnackbar.to.show(response.error!.content!);
    }
  }

  Future _getLocal() async {
    final response = await _localTowersProvider.getAll();

    if (response.isSuccess) {
      _towers = response.data ?? [];
    } else {
      CustomSnackbar.to.show(response.error!.content!);
    }
  }

  Future _setLocal(List<TowerModel> data) async {
    final response = await _localTowersProvider.set(
      data,
    );

    if (response.isSuccess) {
      _towers = data;
    } else {
      CustomSnackbar.to.show(response.error!.content!);
    }
  }

  void filterTowersByInstallation(int installationId) {
    towersFiltered = _towers.where((e) {
      return e.installationId ==
          Get.find<NewInspectionController>().selectedInstallation!.id;
    }).toList();
  }

  String lastUpdate = "";
  Future _getLastTimeUpdated() async {
    final response = await _localTowersProvider.getLastTimeUpdated();

    if (response.isSuccess) {
      lastUpdate = formatDateTimeForString(response.data!);
    }
  }
}
