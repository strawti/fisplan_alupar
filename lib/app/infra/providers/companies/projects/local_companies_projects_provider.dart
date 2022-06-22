import 'package:fisplan_alupar/app/infra/models/responses/project_model.dart';

import '../../../models/defaults/app_error_model.dart';
import '../../../models/defaults/provider_response_model.dart';
import '../../../repositories/companies/projects/local/local_companies_projects_repository.dart';

class LocalCompaniesProjectsProvider {
  final LocalCompaniesProjectsRepository _repository;
  LocalCompaniesProjectsProvider(this._repository);

  Future<ProviderResponseModel<List<ProjectModel>?>> getAll() async {
    try {
      final response = await _repository.getAll();
      return ProviderResponseModel(data: response);
    } catch (e) {
      return AppErrorDefaultModel('LocalCompaniesProjectsProvider.getAll() $e');
    }
  }

  Future<ProviderResponseModel> set(
    List<ProjectModel> data,
  ) async {
    try {
      await _repository.set(data);
      return ProviderResponseModel();
    } catch (e) {
      return AppErrorDefaultModel(
        'LocalCompaniesProjectsProvider.set() $e',
      );
    }
  }

  Future<ProviderResponseModel> clear() async {
    try {
      await _repository.clear();
      return ProviderResponseModel();
    } catch (e) {
      return AppErrorDefaultModel(
        'LocalCompaniesProjectsProvider.clear() $e',
      );
    }
  }
}
