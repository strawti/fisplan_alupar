import 'package:get/get.dart';

import '../../api_endpoints.dart';
import '../../models/defaults/api_error_default_model.dart';
import '../../models/defaults/api_response_model.dart';
import '../../models/defaults/default_response_model.dart';

class LogoutRepository {
  LogoutRepository(this._connect);
  final GetConnect _connect;

  Future<ApiResponseModel> logout() async {
    final response = await _connect.post(apiLogout, null);

    final responseModel = DefaultResponseModel.fromMap(
      {
        'success': response.statusCode == 200,
        'statusCode': response.statusCode,
        'data': response.body,
        'error': {
          'message': response.statusText,
        },
      },
    );

    if (responseModel.success) {
      return ApiResponseModel(data: responseModel);
    }

    return ApiErrorDefaultModel(
      message: 'Não foi possível desconectar o usuário',
      response: responseModel,
    );
  }
}
