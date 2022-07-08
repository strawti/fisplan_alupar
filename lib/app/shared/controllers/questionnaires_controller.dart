import 'package:get/get.dart';

import '../../core/app_connectivity.dart';
import '../../infra/models/responses/questionnary_model.dart';
import '../../infra/providers/companies/projects/companies_projects_questionnaires_provider.dart';
import '../../infra/providers/companies/projects/local/local_companies_projects_questionnaires_provider.dart';
import '../../presenter/home/home_controller.dart';
import '../utils/custom_snackbar.dart';
import '../utils/get_datetime.dart';
import '../utils/loader_manager.dart';

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
      final isWifi = await AppConnectivity.instance.isWifi();
      if (_questionnaires.isEmpty || online || isWifi) {
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

  void filterByProjectId(int projectId) {
    questionnairesFiltered = _questionnaires.where((e) {
      return e.projectId == projectId;
    }).toList();
  }

  List<Question> filterBy(
    int? equipmentCategoryId,
    int activityId,
    int stepId,
  ) {
    var data = questionnairesFiltered.first.questions.where((e) {
      return e.activityId == activityId && e.stepId == stepId;
    }).toList();

    if (equipmentCategoryId != null) {
      data = data.where((e) {
        return e.equipmentCategoryId == equipmentCategoryId;
      }).toList();
    }

    return data;
  }

  String lastUpdate = "";
  Future _getLastTimeUpdated() async {
    final response = await _localProvider.getLastTimeUpdated();

    if (response.isSuccess) {
      lastUpdate = formatDateTimeForString(response.data!);
    }
  }
}
