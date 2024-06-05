import 'package:flutter/material.dart';
import 'package:onlinebozor/presentation/di/get_it_injection.dart';
import 'package:onlinebozor/presentation/support/colors/dark_theme_colors.dart';
import 'package:onlinebozor/presentation/support/colors/light_theme_colors.dart';
import 'package:onlinebozor/presentation/support/colors/theme_colors.dart';

extension ColorExtension on BuildContext {
  ThemeColors get colors => Theme.of(this).brightness == Brightness.dark
      ? DarkThemeColors()
      : LightThemeColors();
// ? getIt<DarkThemeColors>()
//       : getIt<LightThemeColors>();

  ThemeData get theme => Theme.of(this);

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  Color get backgroundColor => Theme.of(this).colorScheme.secondary;

  Color get bottomSheetColor => Theme.of(this).colorScheme.surface;

  Color get bottomNavigationColor => Theme.of(this).colorScheme.background;

  Color get appBarColor => Theme.of(this).colorScheme.secondary;

  Color get bottomBarColor => Theme.of(this).colorScheme.background;

  Color get cardColor => Theme.of(this).colorScheme.surface;

  Color get cardStrokeColor => Theme.of(this).cardColor;

  Color get textPrimary => colors.textPrimary;

  Color get textSecondary => colors.textSecondary;

  Color get textTertiary => colors.textTertiary;

  Color get textPrimaryInverse => colors.textPrimaryInverse;

  Color get inputBackgroundColor => Theme.of(this).colorScheme.secondary;

  Color get inputStrokeActiveColor => colors.buttonPrimary;

  Color get inputStrokeInactiveColor => Theme.of(this).colorScheme.surface;

  Color get iconPrimary => colors.iconPrimary;

  Color get iconSecondary => colors.iconSecondary;
}
