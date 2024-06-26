import 'package:flutter/material.dart';
import 'package:onlinebozor/presentation/support/colors/dark_theme_colors.dart';
import 'package:onlinebozor/presentation/support/colors/light_theme_colors.dart';
import 'package:onlinebozor/presentation/support/colors/static_colors.dart';
import 'package:onlinebozor/presentation/support/colors/theme_colors.dart';

extension ColorExtension on BuildContext {
  ThemeColors get colors => isDarkMode ? DarkThemeColors() : LightThemeColors();

  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  Brightness get brightness => Theme.of(this).brightness;

  ThemeData get theme => Theme.of(this);

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  Color get backgroundGreyColor =>
      isDarkMode ? Color(0xFF121212) : Color(0xFFF2F4FB);

  Color get backgroundWhiteColor => Theme.of(this).colorScheme.secondary;

  Color get bottomSheetColor => Theme.of(this).colorScheme.surface;

  Color get bottomNavigationColor => Theme.of(this).colorScheme.background;

  Color get appBarColor => Theme.of(this).colorScheme.secondary;

  Color get elevatedColor => isDarkMode ? Color(0xFF333333) : Color(0xFFFFFFFF);

  Color get bottomBarColor => Theme.of(this).colorScheme.background;

  Color get cardColor => isDarkMode ? Color(0xFF333333) : Color(0xFFFFFFFF);

  Color get cardStrokeColor => Theme.of(this).cardColor;

  Color get textPrimary => colors.textPrimary;

  Color get textSecondary => colors.textSecondary;

  Color get textTertiary => colors.textTertiary;

  Color get textPrimaryInverse => colors.textPrimaryInverse;

  Color get inputBackgroundColor =>
      isDarkMode ? Color(0x80333131) : Color(0xFFFBFAFF);

  Color get inputStrokeActiveColor => colors.buttonPrimary;

  Color get inputStrokeInactiveColor =>
      isDarkMode ? Color(0xCCF6F7FC) : Color(0xFFDFE2E9);

  Color get iconPrimary =>
      isDarkMode ? StaticColors.iconPrimaryDark : StaticColors.iconPrimaryLight;

  Color get iconSecondary => colors.iconSecondary;
}
