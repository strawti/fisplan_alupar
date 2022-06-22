import '../../../infra/models/responses/installation_type_model.dart';
import '../../../infra/providers/installations/local/local_installations_type_provider.dart';
import '../../../shared/utils/custom_snackbar.dart';
import '../../../shared/utils/loader_manager.dart';
import 'package:get/get.dart';

import '../../../core/app_connectivity.dart';
import '../../../infra/providers/installations/installations_type_provider.dart';

class InstallationTypeController extends GetxController with LoaderManager {
  static InstallationTypeController get to => Get.find();

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
      if (_installationTypes.isEmpty || online) {
        await _getAll();
      }
    }

    installationTypesFiltered = _installationTypes.toList();

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
}
