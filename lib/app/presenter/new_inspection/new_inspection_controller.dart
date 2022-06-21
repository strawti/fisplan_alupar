import 'package:fisplan_alupar/app/infra/models/installation_type_model.dart';
import 'package:get/get.dart';

import '../../infra/models/defaults/item_selection_model.dart';
import '../../routes/arguments/selection_page_arguments.dart';
import '../selection_page/selection_page.dart';
import 'controllers/installation_type_controller.dart';

class NewInspectionController extends GetxController {
  InstallationTypeModel? installationType;

  Future getInstallationType() async {
    final data = Get.find<InstallationTypeController>().installationTypes;

    final InstallationTypeModel? result = await goToSelectionPage(
      'Selecione o tipo de instalação',
      data,
    );

    if (result != null) {
      installationType = result;
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
