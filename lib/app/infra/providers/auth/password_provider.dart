import 'dart:io';

import '../../models/defaults/app_error_model.dart';
import '../../models/defaults/provider_response_model.dart';
import '../../models/requests/auth/recovery_password_request_model.dart';
import '../../repositories/auth/password_repository.dart';

class PasswordProvider {
  final ForgotPasswordRepository _repository;
  PasswordProvider(this._repository);

  Future<ProviderResponseModel> recoveryPassword(
      RecoveryPasswordRequestModel requestModel) async {
    try {
      final response = await _repository.recoveryPassword(requestModel);
      return ProviderResponseModel.fromMap(response.toMap());
    } on SocketException {
      return AppErrorDefaultModel('Erro de conexão');
    } catch (e) {
      return AppErrorDefaultModel('PasswordProvider.recoveryPassword() $e');
    }
  }
}
