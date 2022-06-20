import 'dart:io';

import 'package:fisplan_alupar/app/infra/models/tower_model.dart';

import '../../core/app_constants.dart';
import '../models/defaults/app_error_model.dart';
import '../models/defaults/provider_response_model.dart';
import '../repositories/towers/towers_repository.dart';

class TowersProvider {
  final TowersRepository _repository;
  TowersProvider(this._repository);

  Future<ProviderResponseModel<List<TowerModel>>> getAll(
    int userCompanyId,
  ) async {
    try {
      final response = await _repository.getAllByCompanyId(userCompanyId);
      return ProviderResponseModel.fromMap(response.toMap());
    } on SocketException {
      return AppErrorDefaultModel(constSocketExceptionError);
    } catch (e) {
      return AppErrorDefaultModel('TowersProvider.getAll() $e');
    }
  }
}
