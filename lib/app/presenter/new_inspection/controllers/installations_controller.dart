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

  @override
  void onReady() {
    super.onReady();
    fetch();
  }

  List<InstallationModel> _installations = [];
  List<InstallationModel> installationsFiltered = [];

  Future<void> fetch({bool online = false}) async {
    setIsLoading(true);

    await _getLocalInstallations();
    if (await AppConnectivity.instance.isConnected()) {
      if (_installations.isEmpty || online) {
        await _getInstallations();
      }
    }

    installationsFiltered = _installations.toList();

    setIsLoading(false);
  }

  Future _getInstallations() async {
    final response = await _installationsProvider.getAll();

    if (response.isSuccess) {
      _installations = response.data ?? [];
      _setLocalInstallations(_installations);
    } else {
      CustomSnackbar.to.show(response.error!.content!);
    }
  }

  Future _getLocalInstallations() async {
    final response = await _localInstallationsProvider.getAll();

    if (response.isSuccess) {
      _installations = response.data ?? [];
    } else {
      CustomSnackbar.to.show(response.error!.content!);
    }
  }

  Future _setLocalInstallations(List<InstallationModel> data) async {
    final response = await _localInstallationsProvider.setInstallations(
      data,
    );

    if (response.isSuccess) {
      _installations = data;
    } else {
      CustomSnackbar.to.show(response.error!.content!);
    }
  }

  void filterByInstallationTypeId(int installationTypeId) {
    installationsFiltered = _installations.where((installation) {
      return installation.installationTypeId == installationTypeId;
    }).toList();

    update();
  }
}
