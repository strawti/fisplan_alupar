import 'package:fisplan_alupar/app/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin LoaderManager on GetxController {
  bool isLoading = false;
  void setIsLoading(bool newValue) {
    isLoading = newValue;

    if (isLoading) {
      Get.dialog(
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: appPrimaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator.adaptive(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
           
          ],
        ),
      );
    } else {
      Get.back();
    }

    update();
  }
}
