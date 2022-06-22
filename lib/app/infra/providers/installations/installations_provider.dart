import 'dart:io';

import 'package:fisplan_alupar/app/infra/repositories/installations/installations_repository.dart';

import '../../../core/app_constants.dart';
import '../../models/defaults/app_error_model.dart';
import '../../models/defaults/provider_response_model.dart';
import '../../models/responses/installation_model.dart';

class InstallationsProvider {
  final InstallationsRepository _repository;
  InstallationsProvider(this._repository);

  Future<ProviderResponseModel<List<InstallationModel>?>> getAll() async {
    try {
      final response = await _repository.getAll();
      return ProviderResponseModel.fromMap(response.toMap());
    } on SocketException {
      return AppErrorDefaultModel(constSocketExceptionError);
    } catch (e) {
      return AppErrorDefaultModel('InstallationsProvider.getAll() $e');
    }
  }
}
