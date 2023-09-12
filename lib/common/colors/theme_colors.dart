import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/colors/static_colors.dart';

@lazySingleton
class ThemeColors {
  Color get primary => StaticColors.dodgerBlue;
  Color get onPrimary => StaticColors.white;
}