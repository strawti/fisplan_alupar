import '../../../infra/models/responses/tower_model.dart';
import '../../../infra/providers/towers/towers_provider.dart';
import '../../home/home_controller.dart';
import 'package:get/get.dart';

import '../../../core/app_connectivity.dart';
import '../../../infra/providers/towers/local_towers_provider.dart';
import '../../../shared/utils/custom_snackbar.dart';
import '../../../shared/utils/loader_manager.dart';

class TowersController extends GetxController with LoaderManager {
  static TowersController get to => Get.find();
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

    if (await AppConnectivity.instance.isConnected()) {
      if (_towers.isEmpty || online) {
        await _getAll();
      }
    }

    towersFiltered = _towers.toList();

    setIsLoading(false);
  }

  Future _getAll() async {
    final response = await _towersProvider.getAll(
      Get.find<HomeController>().user!.companyId,
    );

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
}
