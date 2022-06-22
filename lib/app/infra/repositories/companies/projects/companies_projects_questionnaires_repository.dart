import 'package:fisplan_alupar/app/infra/api_endpoints.dart';
import 'package:fisplan_alupar/app/infra/models/responses/project_model.dart';
import 'package:get/get.dart';

import '../../../models/defaults/api_error_default_model.dart';
import '../../../models/defaults/api_response_model.dart';
import '../../../models/defaults/default_response_model.dart';

class CompaniesProjectsQuestionnairesRepository {
  final GetConnect _connect;
  CompaniesProjectsQuestionnairesRepository(this._connect);

  Future<ApiResponseModel<List<ProjectModel>>> getAllByCompanyId(
    int userCompanyId,
  ) async {
    final response = await _connect.get(
      "$apiCompanies/$userCompanyId/by-projects/questionnaires",
    );

    final responseModel = DefaultResponseModel.fromMap({
      'success': response.statusCode == 200,
      'statusCode': response.statusCode,
      'data': response.body,
      'error': {
        'message': response.statusText,
      },
    });

    if (responseModel.success) {
      return ApiResponseModel(
        data: List<ProjectModel>.from(
          responseModel.data.map(
            (e) => ProjectModel.fromMap(e),
          ),
        ),
      );
    }

    return ApiErrorDefaultModel(
      message: 'Não foi possível obter dados',
      response: responseModel,
    );
  }
}
