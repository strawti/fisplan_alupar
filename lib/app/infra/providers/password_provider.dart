import 'dart:io';

import '../models/defaults/app_error_model.dart';
import '../models/defaults/provider_response_model.dart';
import '../models/requests/recovery_password_request_model.dart';
import '../repositories/password_repository.dart';

class PasswordProvider {
  final PasswordRepository _repository;
  PasswordProvider(this._repository);

  Future<ProviderResponseModel> recoveryPassword(
      RecoveryPasswordRequestModel requestModel) async {
    try {
      final _response = await _repository.recoveryPassword(requestModel);
      return ProviderResponseModel.fromMap(_response.toMap());
    } on SocketException {
      return AppErrorDefaultModel('Erro de conexão');
    } catch (e) {
      return AppErrorDefaultModel('PasswordProvider.recoveryPassword() $e');
    }
  }
}
