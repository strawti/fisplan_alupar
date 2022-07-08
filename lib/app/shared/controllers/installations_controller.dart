import 'package:get/get.dart';

import '../../core/app_connectivity.dart';
import '../../infra/models/responses/installation_model.dart';
import '../../infra/providers/installations/installations_provider.dart';
import '../../infra/providers/installations/local/local_installations_provider.dart';
import '../utils/custom_snackbar.dart';
import '../utils/get_datetime.dart';
import '../utils/loader_manager.dart';

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

  List<InstallationModel> _installations = [];
  List<InstallationModel> installationsFiltered = [];

  Future<void> fetch({bool online = false}) async {
    setIsLoading(true);

    await _getLocalInstallations();
    installationsFiltered = _installations.toList();

    if (await AppConnectivity.instance.isConnected()) {
      final isWifi = await AppConnectivity.instance.isWifi();
      if (_installations.isEmpty || online || isWifi) {
        await _getInstallations();
        _getLastTimeUpdated();
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

  void filterByInstallationTypeId(int installationTypeId, int projectId) {
    installationsFiltered = _installations.where((installation) {
      return installation.installationTypeId == installationTypeId &&
          installation.projectId == projectId;
    }).toList();

    update();
  }

  String lastUpdate = "";
  Future _getLastTimeUpdated() async {
    final response = await _localInstallationsProvider.getLastTimeUpdated();

    if (response.isSuccess) {
      lastUpdate = formatDateTimeForString(response.data!);
    }
  }
}
