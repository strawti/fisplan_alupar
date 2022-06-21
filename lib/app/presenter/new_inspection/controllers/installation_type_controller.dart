import 'package:fisplan_alupar/app/infra/models/installation_type_model.dart';
import 'package:fisplan_alupar/app/infra/providers/local/installations/local_installations_type_provider.dart';
import 'package:fisplan_alupar/app/shared/utils/custom_snackbar.dart';
import 'package:fisplan_alupar/app/shared/utils/loader_manager.dart';
import 'package:get/get.dart';

import '../../../core/app_connectivity.dart';
import '../../../infra/models/defaults/item_selection_model.dart';
import '../../../infra/providers/installations/installations_type_provider.dart';
import '../../../routes/arguments/selection_page_arguments.dart';
import '../../selection_page/selection_page.dart';

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

  List<InstallationTypeModel> installationTypes = [];

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
    final response = await _installationsTypeProvider.getAll();

    if (response.isSuccess) {
      installationTypes = response.data ?? [];
      _setLocalInstallations(installationTypes);
    } else {
      CustomSnackbar.to.show(response.error!.content!);
    }
  }

  Future _getLocalInstallations() async {
    final response = await _localInstallationsTypeProvider.getAll();

    if (response.isSuccess) {
      installationTypes = response.data ?? [];
    } else {
      CustomSnackbar.to.show(response.error!.content!);
    }
  }

  Future _setLocalInstallations(List<InstallationTypeModel> data) async {
    final response = await _localInstallationsTypeProvider.setInstallations(
      data,
    );

    if (response.isSuccess) {
      installationTypes = data;
    } else {
      CustomSnackbar.to.show(response.error!.content!);
    }
  }

  InstallationTypeModel? selectedInstallationType;
  Future getInstallationType() async {
    final InstallationTypeModel? result = await goToSelectionPage(
      'Selecione o tipo de instalação',
      installationTypes,
    );

    if (result != null) {
      selectedInstallationType = result;
    }
  }

  Future goToSelectionPage(String title, List data) async {
    return await Get.toNamed(
      SelectionPage.route,
      arguments: SelectionPageArguments(
        title: title,
        items: data.map(
          (e) {
            return ItemSelectionModel(
              title: e.name,
              item: e,
            );
          },
        ).toList(),
      ),
    );
  }
}
