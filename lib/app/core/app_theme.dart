import 'package:flutter/material.dart';

import 'app_colors.dart';

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
    foregroundColor: Colors.white,
  ),
  appBarTheme: const AppBarTheme(
    color: appPrimaryColor,
    elevation: 0.0,
    centerTitle: true,
  ),
  cardColor: Colors.black12,
);
