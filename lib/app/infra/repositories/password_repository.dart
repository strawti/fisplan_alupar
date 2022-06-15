import 'package:get/get.dart';

import '../api_endpoints.dart';
import '../models/defaults/api_error_default_model.dart';
import '../models/defaults/api_response_model.dart';
import '../models/defaults/default_response_model.dart';
import '../models/requests/recovery_password_request_model.dart';

class PasswordRepository {
  final GetConnect _connect;
  const PasswordRepository(this._connect);

  Future<ApiResponseModel> recoveryPassword(
    RecoveryPasswordRequestModel requestModel,
  ) async {
    final response = await _connect.post(
      apiRecoveryPassword,
      requestModel.toMap(),
    );

    final responseModel = DefaultResponseModel.fromMap(response.body);
    if (responseModel.success) {
      return ApiResponseModel(data: responseModel.data);
    }

    return ApiErrorDefaultModel(
      message: 'Não foi possível recuperar sua senha.',
      response: responseModel,
    );
  }
}
