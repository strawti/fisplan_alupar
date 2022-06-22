import '../../../models/defaults/app_error_model.dart';
import '../../../models/defaults/provider_response_model.dart';
import '../../../models/responses/tension_level_model.dart';
import '../../../repositories/companies/tension_levels/local_companies_tension_levels_repository.dart';

class LocalCompaniesTensionLevelsProvider {
  final LocalCompaniesTensionLevelsRepository _repository;
  LocalCompaniesTensionLevelsProvider(this._repository);

  Future<ProviderResponseModel<List<TensionLevelModel>?>> getAll() async {
    try {
      final response = await _repository.getAll();
      return ProviderResponseModel(data: response);
    } catch (e) {
      return AppErrorDefaultModel(
        'LocalCompaniesTensionLevelsProvider.getAll() $e',
      );
    }
  }

  Future<ProviderResponseModel> set(
    List<TensionLevelModel> data,
  ) async {
    try {
      await _repository.set(data);
      return ProviderResponseModel();
    } catch (e) {
      return AppErrorDefaultModel(
        'LocalCompaniesTensionLevelsProvider.set() $e',
      );
    }
  }

  Future<ProviderResponseModel> clear() async {
    try {
      await _repository.clear();
      return ProviderResponseModel();
    } catch (e) {
      return AppErrorDefaultModel(
        'LocalCompaniesTensionLevelsProvider.clear() $e',
      );
    }
  }
}
