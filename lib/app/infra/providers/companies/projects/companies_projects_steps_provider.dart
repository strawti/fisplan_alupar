import 'dart:io';

import '../../../models/responses/step_model.dart';

import '../../../../core/app_constants.dart';
import '../../../models/defaults/app_error_model.dart';
import '../../../models/defaults/provider_response_model.dart';
import '../../../repositories/companies/projects/companies_projects_steps_repository.dart';

class CompaniesProjectsStepsProvider {
  final CompaniesProjectsStepsRepository _repository;
  CompaniesProjectsStepsProvider(this._repository);

  Future<ProviderResponseModel<List<StepModel>?>> getAll(
    int userCompanyId,
  ) async {
    try {
      final response = await _repository.getAllByCompanyId(userCompanyId);
      return ProviderResponseModel.fromMap(response.toMap());
    } on SocketException {
      return AppErrorDefaultModel(constSocketExceptionError);
    } catch (e) {
      return AppErrorDefaultModel(
        'CompaniesProjectsStepsProvider.getAllByCompanyId() $e',
      );
    }
  }
}
