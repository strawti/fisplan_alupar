import '../../models/defaults/app_error_model.dart';
import '../../models/defaults/provider_response_model.dart';
import '../../models/responses/activity_model.dart';
import '../../repositories/activities/local_activities_repository.dart';

class LocalActivitiesProvider {
  final LocalActivitiesRepository _repository;
  LocalActivitiesProvider(this._repository);

  Future<ProviderResponseModel<List<ActivityModel>>> getAll() async {
    try {
      final response = await _repository.getAll();
      return ProviderResponseModel(data: response);
    } catch (e) {
      return AppErrorDefaultModel('LocalActivitiesProvider.getAll() $e');
    }
  }

  Future<ProviderResponseModel> set(
    List<ActivityModel> data,
  ) async {
    try {
      await _repository.set(data);
      return ProviderResponseModel();
    } catch (e) {
      return AppErrorDefaultModel('LocalActivitiesProvider.set() $e');
    }
  }

  Future<ProviderResponseModel> clear() async {
    try {
      await _repository.clear();
      return ProviderResponseModel();
    } catch (e) {
      return AppErrorDefaultModel('LocalActivitiesProvider.clear() $e');
    }
  }

  Future<ProviderResponseModel<DateTime>> getLastTimeUpdated() async {
    try {
      final response = await _repository.getLastTimeUpdated();
      return ProviderResponseModel(data: response);
    } catch (e) {
      return AppErrorDefaultModel(
        'LocalActivitiesProvider.getLastTimeUpdated() $e',
      );
    }
  }
}
