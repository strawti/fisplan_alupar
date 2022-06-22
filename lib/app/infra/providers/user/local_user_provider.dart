import '../../models/defaults/app_error_model.dart';
import '../../models/defaults/provider_response_model.dart';
import '../../models/responses/user_response_model.dart';
import '../../repositories/user/local_user_repository.dart';

class LocalUserProvider {
  final LocalUserRepository _repository;
  LocalUserProvider(this._repository);

  Future<ProviderResponseModel<UserResponseModel?>> getUser() async {
    try {
      final response = await _repository.getUser();
      return ProviderResponseModel(data: response);
    } catch (e) {
      return AppErrorDefaultModel('LocalUserProvider.getUser() $e');
    }
  }

  Future<ProviderResponseModel> setUser(UserResponseModel user) async {
    try {
      await _repository.setUser(user);
      return ProviderResponseModel();
    } catch (e) {
      return AppErrorDefaultModel('LocalUserProvider.setUser() $e');
    }
  }

  Future<ProviderResponseModel> deleteUser() async {
    try {
      await _repository.deleteUser();
      return ProviderResponseModel();
    } catch (e) {
      return AppErrorDefaultModel('LocalUserProvider.deleteUser() $e');
    }
  }
}
