import 'package:get/get.dart';

import '../../../core/app_connectivity.dart';
import '../../../infra/models/responses/installation_model.dart';
import '../../../infra/providers/installations/installations_provider.dart';
import '../../../infra/providers/local/installations/local_installations_provider.dart';
import '../../../shared/utils/custom_snackbar.dart';
import '../../../shared/utils/loader_manager.dart';

class InstallationsController extends GetxController with LoaderManager {
  static InstallationsController get to => Get.find();

  final InstallationsProvider _installationsProvider;
  final LocalInstallationsProvider _localInstallationsProvider;

  InstallationsController(
    this._installationsProvider,
    this._localInstallationsProvider,
  );

  List<InstallationModel> installations = [];

  Future<void> fetch(int installationTypeId) async {
    setIsLoading(true);

    if (await AppConnectivity.instance.isConnected()) {
      await _getInstallations(installationTypeId);
    } else {
      await _getLocalInstallations();
    }

    setIsLoading(false);
  }

  Future _getInstallations(int installationTypeId) async {
    final response = await _installationsProvider.getAll(installationTypeId);

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
