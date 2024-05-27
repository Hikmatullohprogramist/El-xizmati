import 'package:flutter/cupertino.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';

import 'package:onlinebozor/core/gen/localization/strings.dart';
import '../button/custom_elevated_button.dart';

class DefaultErrorWidget extends StatelessWidget {
  const DefaultErrorWidget({
    super.key,
    required this.isFullScreen,
    this.onRetryClicked,
  });

  final bool isFullScreen;
  final VoidCallback? onRetryClicked;

  @override
  Widget build(BuildContext context) {
    return isFullScreen
        ? Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Strings.commonErrorMessage
                    .w(400)
                    .s(14)
                    .c(context.textPrimary),
                SizedBox(height: 12),
                if (onRetryClicked != null)
                  CustomElevatedButton(
                    text: Strings.commonRetry,
                    buttonWidth: 180,
                    onPressed: () {
                      if (onRetryClicked != null) onRetryClicked!();
                    },
                  )
              ],
            ),
          )
        : Center(
            child: SizedBox(
              height: 160,
              child: Column(
                children: [
                  Strings.commonEmptyMessage
                      .w(400)
                      .s(14)
                      .c(context.textPrimary),
                  SizedBox(height: 12),
                  CustomElevatedButton(
                    text: Strings.commonRetry,
                    onPressed: () {
                      if (onRetryClicked != null) onRetryClicked!();
                    },
                    buttonWidth: 180,
                  )
                ],
              ),
            ),
          );
  }
}
