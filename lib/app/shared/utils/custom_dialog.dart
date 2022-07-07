import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/app_colors.dart';

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
      onCancel: onCancel,
      onConfirm: onConfirm,
    );
  }
}
