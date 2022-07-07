import '../../../../models/responses/step_model.dart';

import '../../../../models/defaults/app_error_model.dart';
import '../../../../models/defaults/provider_response_model.dart';
import '../../../../repositories/companies/projects/local/local_companies_projects_steps_repository.dart';

class LocalCompaniesProjectsStepsProvider {
  final LocalCompaniesProjectsStepsRepository _repository;
  LocalCompaniesProjectsStepsProvider(this._repository);

  Future<ProviderResponseModel<List<StepModel>?>> getAll() async {
    try {
      final response = await _repository.getAll();
      return ProviderResponseModel(data: response);
    } catch (e) {
      return AppErrorDefaultModel(
        'LocalCompaniesProjectsStepsProvider.getAll() $e',
      );
    }
  }

  Future<ProviderResponseModel> set(
    List<StepModel> data,
  ) async {
    try {
      await _repository.set(data);
      return ProviderResponseModel();
    } catch (e) {
      return AppErrorDefaultModel(
        'LocalCompaniesProjectsStepsProvider.set() $e',
      );
    }
  }

  Future<ProviderResponseModel> clear() async {
    try {
      await _repository.clear();
      return ProviderResponseModel();
    } catch (e) {
      return AppErrorDefaultModel(
        'LocalCompaniesProjectsStepsProvider.clear() $e',
      );
    }
  }

  Future<ProviderResponseModel<DateTime>> getLastTimeUpdated() async {
    try {
      final response = await _repository.getLastTimeUpdated();
      return ProviderResponseModel(data: response);
    } catch (e) {
      return AppErrorDefaultModel(
        'LocalCompaniesProjectsStepsProvider.getLastTimeUpdated() $e',
      );
    }
  }
}
