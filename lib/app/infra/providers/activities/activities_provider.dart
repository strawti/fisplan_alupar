import 'dart:io';

import '../../models/responses/activity_model.dart';
import '../../models/defaults/provider_response_model.dart';
import '../../repositories/activities/activity_repository.dart';

import '../../../core/app_constants.dart';
import '../../models/defaults/app_error_model.dart';

class ActivitiesProvider {
  final ActivitiesRepository _repository;
  ActivitiesProvider(this._repository);

  Future<ProviderResponseModel<List<ActivityModel>?>> getAll() async {
    try {
      final response = await _repository.getAll();
      return ProviderResponseModel.fromMap(response.toMap());
    } on SocketException {
      return AppErrorDefaultModel(constSocketExceptionError);
    } catch (e) {
      return AppErrorDefaultModel('ActivitiesProvider.getAll() $e');
    }
  }
}
