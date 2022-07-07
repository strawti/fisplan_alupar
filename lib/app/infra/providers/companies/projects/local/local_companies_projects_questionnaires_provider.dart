import '../../../../models/defaults/app_error_model.dart';
import '../../../../models/defaults/provider_response_model.dart';
import '../../../../models/responses/questionnary_model.dart';
import '../../../../repositories/companies/projects/local/local_companies_projects_questionnaires_repository.dart';

class LocalCompaniesProjectsQuestionnairesProvider {
  final LocalCompaniesProjectsQustionnairesRepository _repository;
  LocalCompaniesProjectsQuestionnairesProvider(this._repository);

  Future<ProviderResponseModel<List<QuestionnaryModel>?>> getAll() async {
    try {
      final response = await _repository.getAll();
      return ProviderResponseModel(data: response);
    } catch (e) {
      return AppErrorDefaultModel(
        'LocalCompaniesProjectsQuestionnairesProvider.getAll() $e',
      );
    }
  }

  Future<ProviderResponseModel> set(
    List<QuestionnaryModel> data,
  ) async {
    try {
      await _repository.set(data);
      return ProviderResponseModel();
    } catch (e) {
      return AppErrorDefaultModel(
        'LocalCompaniesProjectsQuestionnairesProvider.set() $e,',
      );
    }
  }

  Future<ProviderResponseModel> clear() async {
    try {
      await _repository.clear();
      return ProviderResponseModel();
    } catch (e) {
      return AppErrorDefaultModel(
        'LocalCompaniesProjectsQuestionnairesProvider.clear() $e,',
      );
    }
  }

  Future<ProviderResponseModel<DateTime>> getLastTimeUpdated() async {
    try {
      final response = await _repository.getLastTimeUpdated();
      return ProviderResponseModel(data: response);
    } catch (e) {
      return AppErrorDefaultModel(
        'LocalCompaniesProjectsQuestionnairesProvider.getLastTimeUpdated() $e,',
      );
    }
  }
}
