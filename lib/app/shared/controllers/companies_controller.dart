import 'package:get/get.dart';

import '../../core/app_connectivity.dart';
import '../../infra/models/responses/tension_level_model.dart';
import '../../infra/providers/companies/tension_levels/companies_tension_level_provider.dart';
import '../../infra/providers/companies/tension_levels/local_companies_tension_levels_provider.dart';
import '../../presenter/home/home_controller.dart';
import '../utils/custom_snackbar.dart';
import '../utils/get_datetime.dart';
import '../utils/loader_manager.dart';

class CompaniesTensionLevelController extends GetxController
    with LoaderManager {
  static CompaniesTensionLevelController get to => Get.find();

  final CompaniesTensionLevelProvider _companiesTensionLevelProvider;
  final LocalCompaniesTensionLevelsProvider
      _localCompaniesTensionLevelsProvider;
  CompaniesTensionLevelController(
    this._companiesTensionLevelProvider,
    this._localCompaniesTensionLevelsProvider,
  );

  @override
  void onReady() {
    super.onReady();
    fetch();
  }

  Future<void> fetch({bool online = false}) async {
    setIsLoading(true);

    await _getLocalAll();
    if (await AppConnectivity.instance.isConnected()) {
      if (_tensionLevels.isEmpty || online) {
        await getAll();
      }
    }

    tensionLevelsFiltered = _tensionLevels.toList();
    _getLastTimeUpdated();

    setIsLoading(false);
  }

  List<TensionLevelModel> _tensionLevels = [];
  List<TensionLevelModel> tensionLevelsFiltered = [];

  Future getAll() async {
    final response = await _companiesTensionLevelProvider.getAllByUserCompanyId(
      Get.find<HomeController>().user!.companyId.toInt(),
    );

    if (response.isSuccess) {
      _tensionLevels = response.data ?? [];
      _setLocal(_tensionLevels);
    } else {
      CustomSnackbar.to.show(response.error!.content!);
    }
  }

  Future _getLocalAll() async {
    final response = await _localCompaniesTensionLevelsProvider.getAll();

    if (response.isSuccess) {
      _tensionLevels = response.data ?? [];
    } else {
      CustomSnackbar.to.show(response.error!.content!);
    }
  }

  Future _setLocal(List<TensionLevelModel> data) async {
    final response = await _localCompaniesTensionLevelsProvider.set(
      data,
    );

    if (response.isSuccess) {
      _tensionLevels = data;
    } else {
      CustomSnackbar.to.show(response.error!.content!);
    }
  }

  void filterByProjectAndEquipmentCategory(
    int projectId,
    int equipmentCategoryId,
  ) {
    tensionLevelsFiltered = _tensionLevels
        .where(
          (e) =>
              e.projectId == projectId &&
              e.equipmentCategoryId == equipmentCategoryId,
        )
        .toList();
    update();
  }

  String lastUpdate = "";
  Future _getLastTimeUpdated() async {
    final response =
        await _localCompaniesTensionLevelsProvider.getLastTimeUpdated();

    if (response.isSuccess) {
      lastUpdate = getDateTime(response.data!);
    }
  }
}
