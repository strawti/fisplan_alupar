import 'dart:io';

import '../../models/responses/user_response_model.dart';
import '../../repositories/user/user_repository.dart';

import '../../../core/app_constants.dart';
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
      return AppErrorDefaultModel(constSocketExceptionError);
    } catch (e) {
      return AppErrorDefaultModel('UserProvider.getUser() $e');
    }
  }
}
