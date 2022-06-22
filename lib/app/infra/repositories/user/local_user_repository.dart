import 'package:get_storage/get_storage.dart';

import '../../models/responses/user_response_model.dart';

class LocalUserRepository {
  final GetStorage _storage;
  LocalUserRepository(this._storage);

  Future<void> setUser(UserResponseModel user) async {
    await _storage.write(
      'User_LastTimeUpdated',
      DateTime.now().millisecondsSinceEpoch,
    );
    await _storage.write('user', user.toJson());
  }

  Future<UserResponseModel?> getUser() async {
    final user = await _storage.read('user');
    if (user == null) {
      return null;
    }
    return UserResponseModel.fromJson(user);
  }

  Future<void> deleteUser() async {
    await _storage.remove('user');
  }

  Future<DateTime> getLastTimeUpdated() async {
    final lastTimeUpdated = await _storage.read('User_LastTimeUpdated');
    return DateTime.fromMillisecondsSinceEpoch(lastTimeUpdated);
  }
}
