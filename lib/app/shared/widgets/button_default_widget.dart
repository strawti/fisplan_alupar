import 'package:auto_size_text/auto_size_text.dart';
import 'package:fisplan_alupar/app/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonDefaultWidget extends StatelessWidget {
  final String title;
  final void Function() onTap;
  final double width;
  final double marginHorizontal;
  final double paddingVertical;
  final Color textColor;
  final Color? backgroundColor;
  final bool isLoading;
  final bool enabled;

  const ButtonDefaultWidget({
    Key? key,
    required this.title,
    required this.onTap,
    this.width = double.maxFinite,
    this.marginHorizontal = 25,
    this.paddingVertical = 13,
    this.textColor = Colors.white,
    this.backgroundColor,
    this.isLoading = false,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: EdgeInsets.symmetric(horizontal: marginHorizontal),
      width: width,
      duration: const Duration(milliseconds: 500),
      child: MaterialButton(
        color: backgroundColor ?? appPrimaryColor,
        disabledColor: backgroundColor?.withOpacity(0.2) ??
            appPrimaryColor.withOpacity(0.2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.symmetric(vertical: paddingVertical),
        onPressed: enabled && !isLoading ? onTap : null,
        child: Visibility(
          visible: !isLoading,
          replacement: const CircularProgressIndicator.adaptive(
            backgroundColor: Colors.white,
          ),
          child: AutoSizeText(
            title,
            style: Get.textTheme.headline1!.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
              color: textColor,
            ),
            maxLines: 1,
            textAlign: TextAlign.center,
            minFontSize: 5,
          ),
        ),
      ),
    );
  }
}
