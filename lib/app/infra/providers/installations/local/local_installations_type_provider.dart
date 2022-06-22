import '../../../models/defaults/app_error_model.dart';
import '../../../models/defaults/provider_response_model.dart';
import '../../../models/responses/installation_type_model.dart';
import '../../../repositories/installations/local/local_installations_type_repository.dart';

class LocalInstallationsTypeProvider {
  final LocalInstallationsTypeRepository _repository;
  LocalInstallationsTypeProvider(this._repository);

  Future<ProviderResponseModel<List<InstallationTypeModel>?>> getAll() async {
    try {
      final response = await _repository.getAll();
      return ProviderResponseModel(data: response);
    } catch (e) {
      return AppErrorDefaultModel('LocalInstallationsTypeProvider.getAll() $e');
    }
  }

  Future<ProviderResponseModel> setInstallations(
    List<InstallationTypeModel> data,
  ) async {
    try {
      await _repository.set(data);
      return ProviderResponseModel();
    } catch (e) {
      return AppErrorDefaultModel(
        'LocalInstallationsTypeProvider.setInstallationTypes() $e',
      );
    }
  }

  Future<ProviderResponseModel> clearInstallations() async {
    try {
      await _repository.clear();
      return ProviderResponseModel();
    } catch (e) {
      return AppErrorDefaultModel(
        'LocalInstallationsTypeProvider.clearInstallationTypes() $e',
      );
    }
  }
}
