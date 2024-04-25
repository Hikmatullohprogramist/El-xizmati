import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/static_colors.dart';

class DefaultLoadingWidget extends StatelessWidget {
  const DefaultLoadingWidget({super.key, required this.isFullScreen});

  final bool isFullScreen;

  @override
  Widget build(BuildContext context) {
    return isFullScreen
        ? Center(
            child: CircularProgressIndicator(
              color: StaticColors.buttonColor,
            ),
          )
        : SizedBox(
            height: 160,
            child: Center(
              child: CircularProgressIndicator(
                color: StaticColors.buttonColor,
              ),
            ),
          );
  }
}
