import 'package:get/get.dart';

mixin LoaderManager on GetxController {
  bool isLoading = false;
  void setIsLoading(bool newValue) {
    isLoading = newValue;

    // if (isLoading) {
    //   if (Get.isDialogOpen == false) {
    //     Get.dialog(
    //       Column(
    //         mainAxisSize: MainAxisSize.min,
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           Container(
    //             padding: const EdgeInsets.all(30),
    //             decoration: BoxDecoration(
    //               color: appPrimaryColor,
    //               borderRadius: BorderRadius.circular(12),
    //             ),
    //             child: Column(
    //               children: [
    //                 const SizedBox(
    //                   width: 60,
    //                   height: 60,
    //                   child: CircularProgressIndicator.adaptive(
    //                     valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
    //                   ),
    //                 ),
    //                 const SizedBox(height: 20),
    //                 Text(
    //                   'Carregando...',
    //                   style: Get.textTheme.headline6?.copyWith(
    //                     color: Colors.white,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    //       barrierDismissible: false,
    //     );
    //   }
    // } else {
    //   if (Get.isDialogOpen == true) {
    //     Get.back();
    //   }
    // }

    update();
  }
}
