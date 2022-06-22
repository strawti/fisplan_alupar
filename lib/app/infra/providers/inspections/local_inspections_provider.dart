import '../../models/defaults/app_error_model.dart';
import '../../models/defaults/provider_response_model.dart';
import '../../models/responses/inspection_model.dart';
import '../../repositories/inspections/local_inspections_repository.dart';

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

  Future<ProviderResponseModel<DateTime>> getLastTimeUpdated() async {
    try {
      final response = await _repository.getLastTimeUpdated();
      return ProviderResponseModel(data: response);
    } catch (e) {
      return AppErrorDefaultModel(
        'LocalInspectionsProvider.getLastTimeUpdated() $e',
      );
    }
  }

  Future<ProviderResponseModel> setUnsynchronized(
    List<InspectionModel> data,
  ) async {
    try {
      await _repository.setUnsynchronized(data);
      return ProviderResponseModel();
    } catch (e) {
      return AppErrorDefaultModel(
        'LocalInspectionsProvider.setUnsynchronized() $e',
      );
    }
  }

  Future<ProviderResponseModel<List<InspectionModel>?>>
      getAllUnsynchronized() async {
    try {
      final response = await _repository.getAllUnsynchronized();
      return ProviderResponseModel(data: response);
    } catch (e) {
      return AppErrorDefaultModel(
        'LocalInspectionsProvider.getAllUnsynchronized() $e',
      );
    }
  }

  Future<ProviderResponseModel> clearUnsynchronized() async {
    try {
      await _repository.clearUnsynchronized();
      return ProviderResponseModel();
    } catch (e) {
      return AppErrorDefaultModel(
        'LocalInspectionsProvider.clearUnsynchronized() $e',
      );
    }
  }
}
