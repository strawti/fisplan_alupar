import 'package:fisplan_alupar/app/infra/models/responses/activity_model.dart';
import 'package:fisplan_alupar/app/infra/repositories/local/activities/local_activities_repository.dart';

import '../../../models/defaults/app_error_model.dart';
import '../../../models/defaults/provider_response_model.dart';

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
}
