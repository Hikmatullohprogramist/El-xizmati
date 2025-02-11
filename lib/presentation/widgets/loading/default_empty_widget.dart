import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:El_xizmati/presentation/support/extensions/color_extension.dart';
import 'package:El_xizmati/core/extensions/text_extensions.dart';
import 'package:flutter/services.dart';
import 'package:El_xizmati/presentation/widgets/button/custom_outlined_button.dart';

import 'package:El_xizmati/core/gen/localization/strings.dart';
import '../button/custom_elevated_button.dart';

class DefaultEmptyWidget extends StatelessWidget {
  const DefaultEmptyWidget({
    super.key,
    required this.isFullScreen,
    this.icon,
    this.message,
    this.onMainActionClicked,
    this.mainActionLabel,
    this.onReloadClicked,
  });

  final bool isFullScreen;
  final Widget? icon;
  final String? message;
  final String? mainActionLabel;
  final VoidCallback? onMainActionClicked;
  final VoidCallback? onReloadClicked;

  @override
  Widget build(BuildContext context) {
    return isFullScreen
        ? Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: _buildBodyItems(context),
              ),
            ),
          )
        : Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                child: Column(
                  children: _buildBodyItems(context),
                ),
              ),
            ),
          );
  }

  List<Widget> _buildBodyItems(BuildContext context) {
    return [
      Visibility(
        visible: isFullScreen,
        child: SizedBox(height: 100),
      ),
      Visibility(
        visible: icon != null,
        child: icon ?? Center(),
      ),
      Visibility(
        visible: icon != null,
        child: SizedBox(height: 42),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: (message ?? Strings.commonEmptyMessage)
                .w(500)
                .s(16)
                .c(context.textPrimary)
                .copyWith(textAlign: TextAlign.center),
          ),
        ],
      ),
      SizedBox(height: 20),
      Visibility(
        visible: onReloadClicked != null,
        child: SizedBox(height: 12),
      ),
      Visibility(
        visible: onReloadClicked != null,
        child: CustomOutlinedButton(
          buttonHeight: 42,
          text: Strings.commonReload,
          // strokeColor: StaticColors.bondiBlue.withAlpha(200),
          onPressed: () {
            onReloadClicked!();
            HapticFeedback.lightImpact();
          },
        ),
      ),
      Visibility(
        visible: onMainActionClicked != null,
        child: SizedBox(height: 20),
      ),
      Visibility(
        visible: onMainActionClicked != null,
        child: CustomElevatedButton(
          buttonHeight: 42,
          text: mainActionLabel ?? Strings.commonRetry,
          onPressed: () {
            onMainActionClicked!();
            HapticFeedback.lightImpact();
          },
        ),
      ),
      SizedBox(height: 20),
    ];
  }
}
