import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/colors/static_colors.dart';

@lazySingleton
class ThemeColors {
  Color get colorBackgroundPrimary => StaticColors.white;

  Color get primary => StaticColors.dodgerBlue;

  Color get onPrimary => StaticColors.white;

  Color get textPrimary => StaticColors.textColorPrimary;

  Color get textAccent => StaticColors.dodgerBlue;

  Color get textSecondary => StaticColors.textColorSecondary;

  Color get textTertiary => StaticColors.cadetBlue;

  Color get textPrimaryInverse => StaticColors.white;

  Color get borderColor => StaticColors.brightGray;

  Color get iconGrey => StaticColors.cadetBlue;

  Color get buttonPrimary => StaticColors.buttonDefaultBackgroundColor;

  Color get adStatusBackground => StaticColors.bondiBlue;

  Color get adPropertyBusinessBackground => StaticColors.business;

  Color get adPropertyPersonalBackground => StaticColors.manatee;
}
