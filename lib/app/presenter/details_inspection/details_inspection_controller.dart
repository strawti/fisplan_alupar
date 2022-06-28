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
}
