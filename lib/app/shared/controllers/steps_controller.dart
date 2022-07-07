import 'package:get/get.dart';

import '../../core/app_connectivity.dart';
import '../../infra/models/responses/step_model.dart';
import '../../infra/providers/companies/projects/companies_projects_steps_provider.dart';
import '../../infra/providers/companies/projects/local/local_companies_projects_steps_provider.dart';
import '../../presenter/home/home_controller.dart';
import '../utils/custom_snackbar.dart';
import '../utils/get_datetime.dart';
import '../utils/loader_manager.dart';

class StepsController extends GetxController with LoaderManager {
  static StepsController get to => Get.find();

  final CompaniesProjectsStepsProvider _provider;
  final LocalCompaniesProjectsStepsProvider _localProvider;

  StepsController(this._provider, this._localProvider);

  @override
  void onReady() {
    super.onReady();
    fetch();
  }

  List<StepModel> _steps = [];
  List<StepModel> stepsFiltered = [];

  Future<void> fetch({bool online = false}) async {
    setIsLoading(true);

    await _getLocal();

    if (await AppConnectivity.instance.isConnected()) {
      if (_steps.isEmpty || online) {
        await _getAll();
      }
    }

    stepsFiltered = _steps.toList();

    _getLastTimeUpdated();

    setIsLoading(false);
  }

  Future _getAll() async {
    final response = await _provider.getAll(
      HomeController.to.user!.companyId,
    );

    if (response.isSuccess) {
      _steps = response.data ?? [];
      _setLocal(_steps);
    } else {
      CustomSnackbar.to.show(response.error!.content!);
    }
  }

  Future _getLocal() async {
    final response = await _localProvider.getAll();

    if (response.isSuccess) {
      _steps = response.data ?? [];
    } else {
      CustomSnackbar.to.show(response.error!.content!);
    }
  }

  Future _setLocal(List<StepModel> data) async {
    final response = await _localProvider.set(
      data,
    );

    if (response.isSuccess) {
      _steps = data;
    } else {
      CustomSnackbar.to.show(response.error!.content!);
    }
  }

  String lastUpdate = "";
  Future _getLastTimeUpdated() async {
    final response = await _localProvider.getLastTimeUpdated();

    if (response.isSuccess) {
      lastUpdate = formatDateTimeForString(response.data!);
    }
  }

  void filterByEquipmentCategoryAndInstallationTypeAndProject(
    int? equipmentCategoryId,
    int installationTypeId,
    int projectId,
  ) {
    stepsFiltered = _steps.where((step) {
      return step.installationTypeId == installationTypeId &&
          step.projectId == projectId;
    }).toList();

    if (equipmentCategoryId != null) {
      stepsFiltered = _steps.where((step) {
        return step.equipmentCategoryId == equipmentCategoryId;
      }).toList();
    }
  }
}
