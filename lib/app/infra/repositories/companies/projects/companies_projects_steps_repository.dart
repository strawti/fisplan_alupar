import 'package:get/get.dart';

import '../../../api_endpoints.dart';
import '../../../models/defaults/api_error_default_model.dart';
import '../../../models/defaults/api_response_model.dart';
import '../../../models/defaults/default_response_model.dart';
import '../../../models/responses/step_model.dart';

class CompaniesProjectsStepsRepository {
  final GetConnect _connect;
  CompaniesProjectsStepsRepository(this._connect);

  Future<ApiResponseModel<List<StepModel>>> getAllByCompanyId(
    int userCompanyId,
  ) async {
    final response = await _connect.get(
      "$apiCompanies/$userCompanyId/by-projects/steps",
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
        data: List<StepModel>.from(
          responseModel.data.map(
            (e) => StepModel.fromMap(e),
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
