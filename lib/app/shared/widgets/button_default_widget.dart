import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/ternary_clean.dart';

class ButtonDefaultWidget extends StatelessWidget {
  final String title;
  final void Function() onTap;
  final double width;
  final double marginHorizontal;
  final double paddingVertical;
  final Color textColor;
  final bool isLoading;
  final bool enabled;
  final Icon? icon;

  const ButtonDefaultWidget({
    Key? key,
    required this.title,
    required this.onTap,
    this.width = double.maxFinite,
    this.marginHorizontal = 25,
    this.paddingVertical = 13,
    this.textColor = Colors.white,
    this.isLoading = false,
    this.enabled = true,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: EdgeInsets.symmetric(
        horizontal: marginHorizontal,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
      ),
      width: width,
      duration: const Duration(milliseconds: 500),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        padding: EdgeInsets.symmetric(
          vertical: paddingVertical,
        ),
        onPressed: enabled && !isLoading ? onTap : null,
        child: Visibility(
          visible: !isLoading,
          replacement: const CircularProgressIndicator.adaptive(
            backgroundColor: Colors.white,
          ),
          child: TernaryClean(
            condition: icon != null,
            caseTrue: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                icon ?? const SizedBox.shrink(),
                AutoSizeText(
                  title,
                  style: Get.textTheme.headline1!.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                  ),
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  minFontSize: 5,
                ),
              ],
            ),
            caseFalse: AutoSizeText(
              title,
              style: Get.textTheme.headline1!.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 16.0,
              ),
              maxLines: 1,
              textAlign: TextAlign.center,
              minFontSize: 5,
            ),
          ),
        ),
      ),
    );
  }
}
