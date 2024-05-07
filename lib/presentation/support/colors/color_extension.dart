import 'package:flutter/material.dart';
import 'package:onlinebozor/presentation/support/colors/theme_colors.dart';
import 'package:onlinebozor/presentation/di/injection.dart';
import 'package:onlinebozor/presentation/support/colors/dark_theme_colors.dart';

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

  Color get primaryContainer => Theme.of(this).colorScheme.primaryContainer;

  Color get primaryContainerStrokeColor => Theme.of(this).cardColor;

  Color get primaryColor => Theme.of(this).primaryColor;

  Color get primaryColorDark => Theme.of(this).primaryColorDark;

  Color get primaryColorLight => Theme.of(this).primaryColorLight;
}
