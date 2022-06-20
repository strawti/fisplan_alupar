import 'package:fisplan_alupar/app/infra/models/requests/auth/login_request_model.dart';
import 'package:get/get.dart';

import '../../../core/app_token.dart';
import '../../api_endpoints.dart';
import '../../models/defaults/api_error_default_model.dart';
import '../../models/defaults/api_response_model.dart';
import '../../models/defaults/default_response_model.dart';
import '../../models/responses/user_response_model.dart';

class LoginRepository {
  LoginRepository(this._connect);
  final GetConnect _connect;

  Future<ApiResponseModel<UserResponseModel>> signIn(
    LoginRequestModel requestModel,
  ) async {
    final response = await _connect.post(
      apiLogin,
      requestModel.toMap(),
    );

    final responseModel = DefaultResponseModel.fromMap(response.body);
    if (responseModel.success) {
      await AppToken.instance.setToken(
        response.body['metadata']['auth']['token'],
      );

      return ApiResponseModel(
        data: UserResponseModel.fromMap(responseModel.data),
      );
    }

    return ApiErrorDefaultModel(
      message: 'Não foi possível autenticar',
      response: responseModel,
    );
  }
}
