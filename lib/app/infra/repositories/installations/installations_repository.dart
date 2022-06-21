import 'package:fisplan_alupar/app/infra/api_endpoints.dart';
import 'package:get/get.dart';

import '../../models/defaults/api_error_default_model.dart';
import '../../models/defaults/api_response_model.dart';
import '../../models/defaults/default_response_model.dart';
import '../../models/installation_model.dart';

class InstallationsRepository {
  final GetConnect _connect;
  InstallationsRepository(this._connect);

  Future<ApiResponseModel<List<InstallationModel>>> getAll(
      int installationTypeId) async {
    final response = await _connect.get(apiInstallations);

    final responseModel = DefaultResponseModel.fromMap({
      'success': response.statusCode == 200,
      'statusCode': response.statusCode,
      'data': response.body,
    });

    if (responseModel.success) {
      return ApiResponseModel(
        data: List<InstallationModel>.from(
          responseModel.data.map(
            (e) => InstallationModel.fromMap(e),
          ),
        ).where((e) => e.installationTypeId == installationTypeId).toList(),
      );
    }

    return ApiErrorDefaultModel(
      message: 'Não foi possível obter dados',
      response: responseModel,
    );
  }
}
