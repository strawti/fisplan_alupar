import 'package:get/get.dart';
import './view_inspection_controller.dart';

class ViewInspectionBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(ViewInspectionController());
    }
}