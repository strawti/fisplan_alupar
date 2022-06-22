import 'dart:io';

import 'package:fisplan_alupar/app/infra/models/defaults/provider_response_model.dart';

import '../../../../core/app_constants.dart';
import '../../../models/defaults/app_error_model.dart';
import '../../../models/responses/project_model.dart';
import '../../../repositories/companies/projects/companies_projects_repository.dart';

class CompaniesProjectsProvider {
  final CompaniesProjectsRepository _repository;
  CompaniesProjectsProvider(this._repository);

  Future<ProviderResponseModel<List<ProjectModel>?>> getAll(
    int userCompanyId,
  ) async {
    try {
      final response = await _repository.getAllByCompanyId(userCompanyId);
      return ProviderResponseModel.fromMap(response.toMap());
    } on SocketException {
      return AppErrorDefaultModel(constSocketExceptionError);
    } catch (e) {
      return AppErrorDefaultModel(
        'CompaniesProjectsProvider.getAllByCompanyId() $e',
      );
    }
  }
}
