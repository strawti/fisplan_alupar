import 'package:get/get.dart';

import '../../../core/app_connectivity.dart';
import '../../../infra/models/installation_model.dart';
import '../../../infra/providers/installations/installations_provider.dart';
import '../../../infra/providers/local/installations/local_installations_provider.dart';
import '../../../shared/utils/custom_snackbar.dart';
import '../../../shared/utils/loader_manager.dart';

class InstallationsController extends GetxController with LoaderManager {
  final InstallationsProvider _installationsProvider;
  final LocalInstallationsProvider _localInstallationsProvider;

  InstallationsController(
    this._installationsProvider,
    this._localInstallationsProvider,
  );

  @override
  void onReady() {
    super.onReady();
    fetch();
  }

  List<InstallationModel> installations = [];

  Future<void> fetch() async {
    setIsLoading(true);

    if (await AppConnectivity.instance.isConnected()) {
      _getInstallations();
    } else {
      await _getLocalInstallations();
    }

    setIsLoading(false);
  }

  Future _getInstallations() async {
    final response = await _installationsProvider.getAll();

    if (response.isSuccess) {
      installations = response.data ?? [];
      _setLocalInstallations(installations);
    } else {
      CustomSnackbar.to.show(response.error!.content!);
    }
  }

  Future _getLocalInstallations() async {
    final response = await _localInstallationsProvider.getAll();

    if (response.isSuccess) {
      installations = response.data ?? [];
    } else {
      CustomSnackbar.to.show(response.error!.content!);
    }
  }

  Future _setLocalInstallations(List<InstallationModel> data) async {
    final response = await _localInstallationsProvider.setInstallations(
      data,
    );

    if (response.isSuccess) {
      installations = data;
    } else {
      CustomSnackbar.to.show(response.error!.content!);
    }
  }
}
