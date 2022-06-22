import 'package:get/get.dart';

import '../../../api_endpoints.dart';
import '../../../models/defaults/api_error_default_model.dart';
import '../../../models/defaults/api_response_model.dart';
import '../../../models/defaults/default_response_model.dart';
import '../../../models/responses/tension_level_model.dart';

class CompaniesTensionLevelsRepository {
  final GetConnect _connect;
  CompaniesTensionLevelsRepository(this._connect);

  Future<ApiResponseModel<List<TensionLevelModel>?>> getAllTensionsByCompanyId(
    int userCompanyId,
  ) async {
    final response = await _connect.get(
      "$apiCompanies/$userCompanyId/tension-levels",
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
        data: List<TensionLevelModel>.from(
          responseModel.data.map(
            (e) => TensionLevelModel.fromMap(e),
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
