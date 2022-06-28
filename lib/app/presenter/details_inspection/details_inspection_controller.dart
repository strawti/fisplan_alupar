import 'package:fisplan_alupar/app/routes/arguments/view_inspection_page_arguments.dart';
import 'package:get/get.dart';

class DetailsInspectionController extends GetxController {
  DetailsInspectionController() {
    assert(
      Get.arguments is ViewInspectionPageArguments,
      "Passe ViewInspectionPageArguments nos argumentos da rota",
    );

    arguments = Get.arguments;
  }

  late ViewInspectionPageArguments arguments;
}
