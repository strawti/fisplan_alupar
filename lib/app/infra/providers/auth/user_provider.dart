import 'dart:io';

import 'package:fisplan_alupar/app/infra/models/responses/user_response_model.dart';
import 'package:fisplan_alupar/app/infra/repositories/auth/user_repository.dart';

import '../../models/defaults/app_error_model.dart';
import '../../models/defaults/provider_response_model.dart';

class UserProvider {
  final UserRepository _repository;
  UserProvider(this._repository);

  Future<ProviderResponseModel<UserResponseModel?>> getUser() async {
    try {
      final response = await _repository.getUser();
      return ProviderResponseModel.fromMap(response.toMap());
    } on SocketException {
      return AppErrorDefaultModel('Erro de conexão');
    } catch (e) {
      return AppErrorDefaultModel('UserProvider.getUser() $e');
    }
  }
}
