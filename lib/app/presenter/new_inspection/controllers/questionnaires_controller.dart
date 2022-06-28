import 'package:fisplan_alupar/app/infra/models/responses/questionnary_model.dart';
import 'package:fisplan_alupar/app/infra/providers/companies/projects/companies_projects_questionnaires_provider.dart';
import 'package:fisplan_alupar/app/infra/providers/companies/projects/local/local_companies_projects_questionnaires_provider.dart';
import 'package:fisplan_alupar/app/presenter/home/home_controller.dart';
import 'package:get/get.dart';

import '../../../core/app_connectivity.dart';
import '../../../shared/utils/custom_snackbar.dart';
import '../../../shared/utils/get_datetime.dart';
import '../../../shared/utils/loader_manager.dart';

class QuestionnairesController extends GetxController with LoaderManager {
  static QuestionnairesController get to => Get.find();

  final CompaniesProjectsQuestionnairesProvider _provider;
  final LocalCompaniesProjectsQuestionnairesProvider _localProvider;

  QuestionnairesController(
    this._provider,
    this._localProvider,
  );

  @override
  void onReady() {
    super.onReady();
    fetch();
  }

  List<QuestionnaryModel> _questionnaires = [];
  List<QuestionnaryModel> questionnairesFiltered = [];

  Future<void> fetch({bool online = false}) async {
    setIsLoading(true);

    await _getLocal();

    if (await AppConnectivity.instance.isConnected()) {
      if (_questionnaires.isEmpty || online) {
        await _getAll();
      }
    }

    questionnairesFiltered = _questionnaires.toList();

    _getLastTimeUpdated();

    setIsLoading(false);
  }

  Future _getAll() async {
    final response = await _provider.getAll(
      HomeController.to.user!.companyId,
    );

    if (response.isSuccess) {
      _questionnaires = response.data ?? [];
      _setLocal(_questionnaires);
    } else {
      CustomSnackbar.to.show(response.error!.content!);
    }
  }

  Future _getLocal() async {
    final response = await _localProvider.getAll();

    if (response.isSuccess) {
      _questionnaires = response.data ?? [];
    } else {
      CustomSnackbar.to.show(response.error!.content!);
    }
  }

  Future _setLocal(List<QuestionnaryModel> data) async {
    final response = await _localProvider.set(
      data,
    );

    if (response.isSuccess) {
      _questionnaires = data;
    } else {
      CustomSnackbar.to.show(response.error!.content!);
    }
  }

  String lastUpdate = "";
  Future _getLastTimeUpdated() async {
    final response = await _localProvider.getLastTimeUpdated();

    if (response.isSuccess) {
      lastUpdate = getDateTime(response.data!);
    }
  }
}
