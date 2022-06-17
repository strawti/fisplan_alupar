import 'dart:io';

import '../models/defaults/app_error_model.dart';
import '../models/defaults/provider_response_model.dart';
import '../models/requests/auth_request_model.dart';
import '../models/responses/user_response_model.dart';
import '../repositories/auth_repository.dart';

class AuthProvider {
  final AuthRepository _repository;
  AuthProvider(this._repository);

  Future<ProviderResponseModel<UserResponseModel>> signIn(
    AuthRequestModel request,
  ) async {
    try {
      final _response = await _repository.signIn(request);
      return ProviderResponseModel.fromMap(_response.toMap());
    } on SocketException {
      return AppErrorDefaultModel('Erro de conexão');
    } catch (e) {
      return AppErrorDefaultModel('AuthProvider.signIn() $e');
    }
  }

  Future<ProviderResponseModel> logout() async {
    try {
      final _response = await _repository.logout();
      return ProviderResponseModel.fromMap(
        _response.toMap(),
      );
    } catch (e) {
      return AppErrorDefaultModel(
        'AuthProvider.logout() $e',
      );
    }
  }
}
