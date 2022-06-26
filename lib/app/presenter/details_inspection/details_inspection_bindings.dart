import 'package:get/get.dart';
import './details_inspection_controller.dart';

class DetailsInspectionBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(DetailsInspectionController());
    }
}