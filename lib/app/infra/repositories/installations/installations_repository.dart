import 'package:fisplan_alupar/app/infra/api_endpoints.dart';
import 'package:get/get.dart';

import '../../models/defaults/api_error_default_model.dart';
import '../../models/defaults/api_response_model.dart';
import '../../models/defaults/default_response_model.dart';
import '../../models/installation_model.dart';

class InstallationsRepository {
  final GetConnect _connect;
  InstallationsRepository(this._connect);

  Future<ApiResponseModel<InstallationModel>> getAll() async {
    final response = await _connect.get(apiInstallations);

    final responseModel = DefaultResponseModel.fromMap({
      'statusCode': response.statusCode,
      'data': response.body,
    });

    if (responseModel.success) {
      return ApiResponseModel(
        data: InstallationModel.fromMap(responseModel.data),
      );
    }

    return ApiErrorDefaultModel(
      message: 'Não foi possível obter dados',
      response: responseModel,
    );
  }
}
