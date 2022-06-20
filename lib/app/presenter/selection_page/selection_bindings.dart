import 'package:get/get.dart';

import 'selection_controller.dart';

class SelectionBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(SelectionController());
  }
}
