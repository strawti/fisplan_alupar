import 'dart:convert';

import 'package:get/get.dart';

import '../../core/app_token.dart';
import '../api_endpoints.dart';
import '../models/defaults/api_error_default_model.dart';
import '../models/defaults/api_response_model.dart';
import '../models/defaults/default_response_model.dart';
import '../models/requests/auth_request_model.dart';
import '../models/responses/user_response_model.dart';

class AuthRepository {
  AuthRepository(this._connect);
  final GetConnect _connect;

  Future<ApiResponseModel<UserResponseModel>> signIn(
    AuthRequestModel requestModel,
  ) async {
    final response = await _connect.post(
      apiLogin,
      requestModel.toMap(),
    );

    final responseModel = DefaultResponseModel.fromMap(response.body);
    if (responseModel.success) {
      await AppToken.instance
          .setToken(response.body['metadata']['auth']['token']);
      return ApiResponseModel(
        data: UserResponseModel.fromMap(responseModel.data),
      );
    }

    return ApiErrorDefaultModel(
      message: 'Não foi possível autenticar',
      response: responseModel,
    );
  }

  Future<ApiResponseModel> logout() async {
    final response = await _connect.post(
      apiLogout,
      json.encode({}),
    );

    final responseModel = DefaultResponseModel.fromMap(
      response.body,
    );
    if (responseModel.success) {
      return ApiResponseModel(
        data: responseModel,
      );
    }

    return ApiErrorDefaultModel(
      message: 'Não foi possível desconectar o usuário',
      response: responseModel,
    );
  }
}
