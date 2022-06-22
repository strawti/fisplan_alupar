import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlertDialogWidget extends StatelessWidget {
  final void Function()? confirmOnPressed;

  /// Null case Get.back is used
  final void Function()? cancelOnPressed;

  final String title;
  final String content;

  const AlertDialogWidget({
    Key? key,
    this.confirmOnPressed,
    this.cancelOnPressed,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        MaterialButton(
          onPressed: confirmOnPressed,
          child: const Text('Sim'),
        ),
        MaterialButton(
          onPressed: cancelOnPressed ?? Get.back,
          child: const Text('Não'),
        ),
      ],
    );
  }
}
