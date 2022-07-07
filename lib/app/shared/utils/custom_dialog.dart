import 'package:fisplan_alupar/app/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDialog {
  Future<dynamic> show({
    required String title,
    String middleText = '',
    String? textConfirm,
    String? textCancel,
    Function()? onCancel,
    Function()? onConfirm,
  }) async {
    return await Get.defaultDialog(
      title: title,
      middleText: middleText,
      barrierDismissible: false,
      textConfirm: textConfirm,
      textCancel: textCancel,
      cancelTextColor: Colors.red,
      buttonColor: appPrimaryColor,
      confirmTextColor: Colors.white,
      onCancel: onCancel ?? Get.back,
      onConfirm: onConfirm,
    );
  }
}
