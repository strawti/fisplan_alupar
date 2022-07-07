import 'dart:io';

import '../../../../core/app_constants.dart';
import '../../../models/defaults/app_error_model.dart';
import '../../../models/defaults/provider_response_model.dart';
import '../../../models/responses/questionnary_model.dart';
import '../../../repositories/companies/projects/companies_projects_questionnaires_repository.dart';

class CompaniesProjectsQuestionnairesProvider {
  final CompaniesProjectsQuestionnairesRepository _repository;
  CompaniesProjectsQuestionnairesProvider(this._repository);

  Future<ProviderResponseModel<List<QuestionnaryModel>?>> getAll(
    int userCompanyId,
  ) async {
    try {
      final response = await _repository.getAllByCompanyId(userCompanyId);
      return ProviderResponseModel.fromMap(response.toMap());
    } on SocketException {
      return AppErrorDefaultModel(constSocketExceptionError);
    } catch (e) {
      return AppErrorDefaultModel(
        'CompaniesProjectsQuestionnairesProvider.getAllByCompanyId() $e',
      );
    }
  }
}
