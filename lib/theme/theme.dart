import 'package:flutter/material.dart';

import 'pallete.dart';

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  splashColor: darksplashColor,
  dialogBackgroundColor: darkdialogBackgroundColor,
  unselectedWidgetColor: darkunselectedWidgetColor,
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    surface: darkBG,
    primary: darkPrimary,
    secondary: darkSecondary,
    tertiary: darkTertiary,
  ),
  fontFamily: 'LotaGrotesqueAlt3',
);

// Define your dark mode theme
ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  splashColor: lightsplashColor,
  dialogBackgroundColor: lightdialogBackgroundColor,
  unselectedWidgetColor: lightunselectedWidgetColor,
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    surface: lightBG,
    primary: lightPrimary,
    secondary: lightSecondary,
    tertiary: lightTertiary,
  ),
  fontFamily: 'LotaGrotesqueAlt3',
);
