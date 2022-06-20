import 'package:fisplan_alupar/app/infra/models/responses/user_response_model.dart';
import 'package:fisplan_alupar/app/infra/providers/auth/user_provider.dart';
import 'package:fisplan_alupar/app/infra/providers/local/local_user_provider.dart';
import 'package:fisplan_alupar/app/shared/utils/loader_manager.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with LoaderManager {
  final LocalUserProvider _localUserProvider;
  final UserProvider _userProvider;

  HomeController(this._localUserProvider, this._userProvider);

  @override
  void onReady() {
    super.onReady();

    fetch();
  }

  Future fetch() async {
    setIsLoading(true);

    await _getLocalUser();
    if (user == null) {
      await _getUser();
    }

    setIsLoading(false);
  }

  UserResponseModel? user;
  Future _getLocalUser() async {
    final response = await _localUserProvider.getUser();
    if (response.isSuccess) {
      user = response.data;
    }
  }

  Future _getUser() async {
    final response = await _userProvider.getUser();
    if (response.isSuccess) {
      user = response.data;
      await _localUserProvider.setUser(response.data!);
    }
  }
}
