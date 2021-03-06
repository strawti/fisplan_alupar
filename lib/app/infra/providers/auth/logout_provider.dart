import '../../models/defaults/app_error_model.dart';
import '../../models/defaults/provider_response_model.dart';
import '../../repositories/auth/logout_repository.dart';

class LogoutProvider {
  final LogoutRepository _repository;
  LogoutProvider(this._repository);

  Future<ProviderResponseModel> logout() async {
    try {
      final response = await _repository.logout();
      return ProviderResponseModel.fromMap(response.toMap());
    } catch (e) {
      return AppErrorDefaultModel('AuthProvider.logout() $e');
    }
  }
}
