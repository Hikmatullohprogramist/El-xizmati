import 'package:flutter/cupertino.dart';
import 'package:onlinebozor/common/colors/theme_colors.dart';
import 'package:onlinebozor/common/di/injection.dart';

extension ColorExtension on BuildContext {
  ThemeColors get colors => getIt<ThemeColors>();
}
