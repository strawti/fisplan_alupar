import '../../../models/defaults/app_error_model.dart';
import '../../../models/defaults/provider_response_model.dart';
import '../../../models/responses/installation_model.dart';
import '../../../repositories/local/installations/local_installations_repository.dart';

class LocalInstallationsProvider {
  final LocalInstallationsRepository _repository;
  LocalInstallationsProvider(this._repository);

  Future<ProviderResponseModel<List<InstallationModel>?>> getAll() async {
    try {
      final response = await _repository.getInstallations();
      return ProviderResponseModel(data: response);
    } catch (e) {
      return AppErrorDefaultModel('LocalInstallationsProvider.getAll() $e');
    }
  }

  Future<ProviderResponseModel> setInstallations(
    List<InstallationModel> data,
  ) async {
    try {
      await _repository.setInstallations(data);
      return ProviderResponseModel();
    } catch (e) {
      return AppErrorDefaultModel(
        'LocalInstallationsProvider.setInstallations() $e',
      );
    }
  }

  Future<ProviderResponseModel> clearInstallations() async {
    try {
      await _repository.clearInstallations();
      return ProviderResponseModel();
    } catch (e) {
      return AppErrorDefaultModel(
        'LocalInstallationsProvider.clearInstallations() $e',
      );
    }
  }
}
