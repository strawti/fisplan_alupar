import 'package:fisplan_alupar/app/infra/api_endpoints.dart';
import 'package:fisplan_alupar/app/infra/models/installation_type_model.dart';
import 'package:get/get.dart';

import '../../models/defaults/api_error_default_model.dart';
import '../../models/defaults/api_response_model.dart';
import '../../models/defaults/default_response_model.dart';

class InstallationsTypeRepository {
  final GetConnect _connect;
  InstallationsTypeRepository(this._connect);

  Future<ApiResponseModel<List<InstallationTypeModel>>> getAll() async {
    final response = await _connect.get(apiInstallationTypes);

    final responseModel = DefaultResponseModel.fromMap({
      'statusCode': response.statusCode,
      'data': response.body,
      'error': {
        'message': response.statusText,
      }
    });

    if (responseModel.success) {
      return ApiResponseModel(
        data: List.from(
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
