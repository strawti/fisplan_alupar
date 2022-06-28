import 'package:get/get.dart';

import '../new_inspection/controllers/audios_controller.dart';
import '../new_inspection/controllers/images_controller.dart';
import 'details_inspection_controller.dart';

class DetailsInspectionBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AudiosController());
    Get.lazyPut(() => ImagesController());
    Get.put(DetailsInspectionController());
  }
}
