import 'package:flutter/material.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';

class CustomIndicator extends StatelessWidget {
  final int itemCount;
  final int currentPageIndex;
  final SvgGenImage activeIcon;
  final SvgGenImage inactiveIcon;

  // final Color activeColor;
  // final Color inactiveColor;

  const CustomIndicator({
    super.key,
    required this.itemCount,
    required this.currentPageIndex,
    required this.activeIcon,
    required this.inactiveIcon,
    // this.activeColor = Colors.blue,
    // this.inactiveColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
          itemCount,
          (index) =>
              (currentPageIndex == index ? activeIcon : inactiveIcon).svg()),
    );
  }
}
