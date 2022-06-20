import 'package:fisplan_alupar/app/infra/models/installation_type_model.dart';
import 'package:fisplan_alupar/app/infra/repositories/local/installations/local_installations_type_repository.dart';

import '../../models/defaults/app_error_model.dart';
import '../../models/defaults/provider_response_model.dart';

class LocalInstallationsTypeProvider {
  final LocalInstallationsTypeRepository _repository;
  LocalInstallationsTypeProvider(this._repository);

  Future<ProviderResponseModel<List<InstallationTypeModel>?>> getAll() async {
    try {
      final response = await _repository.getInstallations();
      return ProviderResponseModel(data: response);
    } catch (e) {
      return AppErrorDefaultModel('LocalInstallationsTypeProvider.getAll() $e');
    }
  }

  Future<ProviderResponseModel> setInstallations(
    List<InstallationTypeModel> data,
  ) async {
    try {
      await _repository.setInstallations(data);
      return ProviderResponseModel();
    } catch (e) {
      return AppErrorDefaultModel(
        'LocalInstallationsTypeProvider.setInstallations() $e',
      );
    }
  }

  Future<ProviderResponseModel> clearInstallations() async {
    try {
      await _repository.clearInstallations();
      return ProviderResponseModel();
    } catch (e) {
      return AppErrorDefaultModel(
        'LocalInstallationsTypeProvider.clearInstallations() $e',
      );
    }
  }
}