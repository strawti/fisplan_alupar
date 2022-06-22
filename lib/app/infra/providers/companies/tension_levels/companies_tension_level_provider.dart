import 'dart:io';

import 'package:fisplan_alupar/app/core/app_constants.dart';
import 'package:fisplan_alupar/app/infra/models/defaults/app_error_model.dart';
import 'package:fisplan_alupar/app/infra/models/defaults/provider_response_model.dart';
import 'package:fisplan_alupar/app/infra/models/responses/tension_level_model.dart';
import 'package:fisplan_alupar/app/infra/repositories/companies/tension_levels/companies_tension_levels_repository.dart';

class CompaniesTensionLevelProvider {
  final CompaniesTensionLevelsRepository _repository;
  CompaniesTensionLevelProvider(this._repository);

  Future<ProviderResponseModel<List<TensionLevelModel>>>
      getAllTensionsByCompanyId(int id) async {
    try {
      final response = await _repository.getAllTensionsByCompanyId(id);
      return ProviderResponseModel.fromMap(response.toMap());
    } on SocketException {
      return AppErrorDefaultModel(constSocketExceptionError);
    } catch (e) {
      return AppErrorDefaultModel(
          'CompaniesTensionLevelProvider.getAllByCompanyId() $e');
    }
  }
}
