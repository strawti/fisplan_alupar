import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewInspectionCard extends StatelessWidget {
  const NewInspectionCard({
    Key? key,
    required this.title,
    this.child,
    this.icon,
  }) : super(key: key);

  final String title;
  final IconButton? icon;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Get.theme.textTheme.headline1!.color,
                  ),
                ),
                icon ?? const SizedBox(),
              ],
            ),
            child ?? const SizedBox(),
          ],
        ),
      ),
    );
  }
}
