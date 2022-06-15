import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void setSystemUIOverlayStyle({
  Color? statusBarColor,
  Brightness? statusBarIconBrightness,
  Brightness? statusBarBrightness,
  Color? systemNavigationBarColor,
  Brightness? systemNavigationBarIconBrightness,
}) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: statusBarColor,
    statusBarIconBrightness: statusBarIconBrightness,
    statusBarBrightness: statusBarBrightness,
    systemNavigationBarColor: systemNavigationBarColor,
    systemNavigationBarIconBrightness: systemNavigationBarIconBrightness,
  ));
}
