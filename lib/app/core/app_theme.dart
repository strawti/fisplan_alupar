import 'package:fisplan_alupar/app/core/app_colors.dart';
import 'package:flutter/material.dart';

final appThemeLight = ThemeData(
  primaryColor: appPrimaryColor,
  splashColor: appPrimaryColor,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: appPrimaryColor,
  ),
  appBarTheme: const AppBarTheme(
    color: appPrimaryColor,
    elevation: 0.0,
    centerTitle: true,
  ),
);

final appThemeDark = ThemeData(
  brightness: Brightness.dark,
  primaryColor: appPrimaryColor,
  splashColor: appPrimaryColor,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: appPrimaryColor,
  ),
  appBarTheme: const AppBarTheme(
    color: appPrimaryColor,
    elevation: 0.0,
    centerTitle: true,
  ),
);
