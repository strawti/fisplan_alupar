import '../../models/requests/auth/login_request_model.dart';
import 'package:get/get.dart';

import '../../api_endpoints.dart';
import '../../models/defaults/api_error_default_model.dart';
import '../../models/defaults/api_response_model.dart';
import '../../models/defaults/default_response_model.dart';

class LoginRepository {
  LoginRepository(this._connect);
  final GetConnect _connect;

  Future<ApiResponseModel<String?>> signIn(
    LoginRequestModel requestModel,
  ) async {
    final response = await _connect.post(
      apiLogin,
      requestModel.toMap(),
    );

    final responseModel = DefaultResponseModel.fromMap({
      'data': response.body,
      'success': response.statusCode == 200,
      'error': {
        'message': response.statusText,
      }
    });

    if (responseModel.success) {
      return ApiResponseModel(data: responseModel.data['token']);
    }

    return ApiErrorDefaultModel(
      message: 'Não foi possível autenticar',
      response: responseModel,
    );
  }
}
