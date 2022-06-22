import '../../../core/app_connectivity.dart';
import '../../../infra/providers/companies/tension_levels/companies_tension_level_provider.dart';
import '../../../infra/providers/companies/tension_levels/local_companies_tension_levels_provider.dart';
import '../../home/home_controller.dart';
import '../../../shared/utils/custom_snackbar.dart';
import '../../../shared/utils/loader_manager.dart';
import 'package:get/get.dart';

import '../../../infra/models/responses/tension_level_model.dart';

class CompaniesController extends GetxController with LoaderManager {
  static CompaniesController get to => Get.find();

  final CompaniesTensionLevelProvider _companiesTensionLevelProvider;
  final LocalCompaniesTensionLevelsProvider
      _localCompaniesTensionLevelsProvider;
  CompaniesController(
    this._companiesTensionLevelProvider,
    this._localCompaniesTensionLevelsProvider,
  );

  Future<void> fetch({bool online = false}) async {
    setIsLoading(true);

    await _getLocalAll();
    if (await AppConnectivity.instance.isConnected()) {
      if (_tensionLevels.isEmpty || online) {
        await getAll();
      }
    }

    tensionLevelsFiltered = _tensionLevels.toList();

    setIsLoading(false);
  }

  List<TensionLevelModel> _tensionLevels = [];
  List<TensionLevelModel> tensionLevelsFiltered = [];

  Future getAll() async {
    final response = await _companiesTensionLevelProvider.getAllByUserCompanyId(
      HomeController.to.user!.companyId,
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
}
