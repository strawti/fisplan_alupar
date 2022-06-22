import 'dart:io';

import '../../../../core/app_constants.dart';
import '../../../models/defaults/app_error_model.dart';
import '../../../models/defaults/provider_response_model.dart';
import '../../../models/responses/tension_level_model.dart';
import '../../../repositories/companies/tension_levels/companies_tension_levels_repository.dart';

class CompaniesTensionLevelProvider {
  final CompaniesTensionLevelsRepository _repository;
  CompaniesTensionLevelProvider(this._repository);

  Future<ProviderResponseModel<List<TensionLevelModel>?>> getAllByUserCompanyId(
    int userCompanyId,
  ) async {
    try {
      final response = await _repository.getAllTensionsByCompanyId(
        userCompanyId,
      );
      return ProviderResponseModel.fromMap(response.toMap());
    } on SocketException {
      return AppErrorDefaultModel(constSocketExceptionError);
    } catch (e) {
      return AppErrorDefaultModel(
        'CompaniesTensionLevelProvider.getAllTensionsByCompanyId() $e',
      );
    }
  }
}
