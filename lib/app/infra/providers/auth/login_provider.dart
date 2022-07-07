import 'dart:io';

import '../../../core/app_constants.dart';
import '../../models/defaults/app_error_model.dart';
import '../../models/defaults/provider_response_model.dart';
import '../../models/requests/auth/login_request_model.dart';
import '../../repositories/auth/login_repository.dart';

class LoginProvider {
  final LoginRepository _repository;
  LoginProvider(this._repository);

  Future<ProviderResponseModel<String?>> signIn(
    LoginRequestModel request,
  ) async {
    try {
      final response = await _repository.signIn(request);
      return ProviderResponseModel.fromMap(response.toMap());
    } on SocketException {
      return AppErrorDefaultModel(constSocketExceptionError);
    } catch (e) {
      return AppErrorDefaultModel('AuthProvider.signIn() $e');
    }
  }
}
