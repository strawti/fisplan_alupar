import 'package:get/get.dart';

import '../../core/app_connectivity.dart';
import '../../infra/models/responses/installation_type_model.dart';
import '../../infra/providers/installations/installations_type_provider.dart';
import '../../infra/providers/installations/local/local_installations_type_provider.dart';
import '../utils/custom_snackbar.dart';
import '../utils/get_datetime.dart';
import '../utils/loader_manager.dart';

class InstallationTypeController extends GetxController with LoaderManager {
  final InstallationsTypeProvider _installationsTypeProvider;
  final LocalInstallationsTypeProvider _localInstallationsTypeProvider;

  InstallationTypeController(
    this._installationsTypeProvider,
    this._localInstallationsTypeProvider,
  );

  @override
  void onReady() {
    super.onReady();
    fetch();
  }

  List<InstallationTypeModel> _installationTypes = [];
  List<InstallationTypeModel> installationTypesFiltered = [];

  Future<void> fetch({bool online = false}) async {
    setIsLoading(true);

    await _getLocalInstallations();
    if (await AppConnectivity.instance.isConnected()) {
      final isWifi = await AppConnectivity.instance.isWifi();
      if (_installationTypes.isEmpty || online || isWifi) {
        await _getAll();
      }
    }

    installationTypesFiltered = _installationTypes.toList();
    _getLastTimeUpdated();

    setIsLoading(false);
  }

  Future _getAll() async {
    final response = await _installationsTypeProvider.getAll();

    if (response.isSuccess) {
      _installationTypes = response.data ?? [];
      _setLocal(_installationTypes);
    } else {
      CustomSnackbar.to.show(response.error!.content!);
    }
  }

  Future _getLocalInstallations() async {
    final response = await _localInstallationsTypeProvider.getAll();

    if (response.isSuccess) {
      _installationTypes = response.data ?? [];
    } else {
      CustomSnackbar.to.show(response.error!.content!);
    }
  }

  Future _setLocal(List<InstallationTypeModel> data) async {
    final response = await _localInstallationsTypeProvider.setInstallations(
      data,
    );

    if (response.isSuccess) {
      _installationTypes = data;
    } else {
      CustomSnackbar.to.show(response.error!.content!);
    }
  }

  String lastUpdate = "";
  Future _getLastTimeUpdated() async {
    final response = await _localInstallationsTypeProvider.getLastTimeUpdated();

    if (response.isSuccess) {
      lastUpdate = formatDateTimeForString(response.data!);
    }
  }
}
