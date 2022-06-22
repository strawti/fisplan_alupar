import 'package:fisplan_alupar/app/core/app_connectivity.dart';
import 'package:fisplan_alupar/app/infra/models/tension_level_model.dart';
import 'package:fisplan_alupar/app/infra/providers/companies/tension_levels/companies_tension_level_provider.dart';
import 'package:fisplan_alupar/app/shared/utils/custom_snackbar.dart';
import 'package:fisplan_alupar/app/shared/utils/loader_manager.dart';
import 'package:get/get.dart';

class CompaniesController extends GetxController with LoaderManager {
  static CompaniesController get to => Get.find();

  final CompaniesTensionLevelProvider _companiesTensionLevelProvider;
  CompaniesController(this._companiesTensionLevelProvider);

  Future<void> fetch(int id) async {
    setIsLoading(true);

    if (await AppConnectivity.instance.isConnected()) {
      await getAllTensionsByCompanyId(id);
    } else {
      // await getAllByCompanyIdLocal();
    }

    setIsLoading(false);
  }

  List<TensionLevelModel> tensionLevels = [];
  Future getAllTensionsByCompanyId(int id) async {
    final response =
        await _companiesTensionLevelProvider.getAllTensionsByCompanyId(id);

    if (response.isSuccess) {
      tensionLevels = response.data ?? [];
      //_setLocal(tensionLevels);
    } else {
      CustomSnackbar.to.show(response.error!.content!);
    }
  }
}
