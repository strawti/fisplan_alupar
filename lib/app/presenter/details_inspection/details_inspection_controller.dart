import 'package:fisplan_alupar/app/infra/models/responses/installation_model.dart';
import 'package:fisplan_alupar/app/presenter/new_inspection/controllers/installations_controller.dart';
import 'package:fisplan_alupar/app/routes/arguments/datails_inspection_page_arguments.dart';
import 'package:get/get.dart';

import '../../routes/arguments/datails_inspection_page_arguments.dart';

class DetailsInspectionController extends GetxController {
  DetailsInspectionController() {
    assert(
      Get.arguments is DetailsInspectionPageArguments,
      "Passe DetailsInspectionPageArguments nos argumentos da rota",
    );

    arguments = Get.arguments;
  }

  late DetailsInspectionPageArguments arguments;

  @override
  void onReady() {
    super.onReady();
    Get.find<InstallationsController>().filterByInstallationTypeId(
      arguments.inspection.installationId,
      arguments.project.id,
    );
  }

  InstallationModel? _intallation;

  String get intallationName => _intallation?.name ?? '';
}
