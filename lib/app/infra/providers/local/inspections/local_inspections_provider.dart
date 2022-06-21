import 'package:fisplan_alupar/app/infra/repositories/local/inspections/local_inspections_repository.dart';

import '../../../models/defaults/app_error_model.dart';
import '../../../models/defaults/provider_response_model.dart';
import '../../../models/inspection_model.dart';

class LocalInspectionsProvider {
  final LocalInspectionsRepository _repository;
  LocalInspectionsProvider(this._repository);

  Future<ProviderResponseModel<List<InspectionModel>?>> getAll() async {
    try {
      final response = await _repository.getAll();
      return ProviderResponseModel(data: response);
    } catch (e) {
      return AppErrorDefaultModel('LocalInspectionsProvider.getAll() $e');
    }
  }

  Future<ProviderResponseModel> set(
    List<InspectionModel> data,
  ) async {
    try {
      await _repository.set(data);
      return ProviderResponseModel();
    } catch (e) {
      return AppErrorDefaultModel(
        'LocalInspectionsProvider.set() $e',
      );
    }
  }

  Future<ProviderResponseModel> clear() async {
    try {
      await _repository.clear();
      return ProviderResponseModel();
    } catch (e) {
      return AppErrorDefaultModel(
        'LocalInspectionsProvider.clear() $e',
      );
    }
  }
}
