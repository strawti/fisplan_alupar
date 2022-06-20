import 'dart:io';

import 'package:fisplan_alupar/app/infra/models/requests/auth/login_request_model.dart';
import 'package:fisplan_alupar/app/infra/repositories/auth/login_repository.dart';

import '../../models/defaults/app_error_model.dart';
import '../../models/defaults/provider_response_model.dart';
import '../../models/responses/user_response_model.dart';

class LoginProvider {
  final LoginRepository _repository;
  LoginProvider(this._repository);

  Future<ProviderResponseModel<UserResponseModel>> signIn(
    LoginRequestModel request,
  ) async {
    try {
      final response = await _repository.signIn(request);
      return ProviderResponseModel.fromMap(response.toMap());
    } on SocketException {
      return AppErrorDefaultModel('Erro de conexão');
    } catch (e) {
      return AppErrorDefaultModel('AuthProvider.signIn() $e');
    }
  }
}
