import 'package:get/get.dart';

import '../../api_endpoints.dart';
import '../../models/defaults/api_error_default_model.dart';
import '../../models/defaults/api_response_model.dart';
import '../../models/defaults/default_response_model.dart';
import '../../models/responses/installation_type_model.dart';

class InstallationsTypeRepository {
  final GetConnect _connect;
  InstallationsTypeRepository(this._connect);

  Future<ApiResponseModel<List<InstallationTypeModel>>> getAll() async {
    final response = await _connect.get(apiInstallationTypes);

    final responseModel = DefaultResponseModel.fromMap({
      'success': response.statusCode == 200,
      'statusCode': response.statusCode,
      'data': response.body,
      'error': {
        'message': response.statusText,
      }
    });

    if (responseModel.success) {
      return ApiResponseModel(
        data: List<InstallationTypeModel>.from(
          responseModel.data.map(
            (e) => InstallationTypeModel.fromMap(e),
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
