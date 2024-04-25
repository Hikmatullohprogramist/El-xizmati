import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/dark_theme_colors.dart';
import 'package:onlinebozor/common/colors/theme_colors.dart';
import 'package:onlinebozor/common/di/injection.dart';

extension ColorExtension on BuildContext {
  ThemeColors get colors => Theme.of(this).brightness == Brightness.dark
      ? getIt<DarkThemeColors>()
      : getIt<ThemeColors>();

  ThemeData get theme => Theme.of(this);

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  Color get backgroundColor => Theme.of(this).colorScheme.background;

  Color get bottomNavigationColor => Theme.of(this).colorScheme.background;

  Color get appBarColor => Theme.of(this).colorScheme.background;

  Color get bottomBarColor => Theme.of(this).colorScheme.background;

  Color get cardColor => Theme.of(this).scaffoldBackgroundColor;

  Color get cardStrokeColor => Theme.of(this).cardColor;

  Color get primaryColor => Theme.of(this).primaryColor;

  Color get primaryColorDark => Theme.of(this).primaryColorDark;

  Color get primaryColorLight => Theme.of(this).primaryColorLight;
}
