import 'package:flutter/cupertino.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';

import '../../gen/localization/strings.dart';
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
                Strings.loadingStateError
                    .w(400)
                    .s(14)
                    .c(context.colors.textPrimary),
                SizedBox(height: 12),
                if (onRetryClicked != null)
                  CustomElevatedButton(
                    text: Strings.loadingStateRetry,
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
                  Strings.loadingStateError
                      .w(400)
                      .s(14)
                      .c(context.colors.textPrimary),
                  SizedBox(height: 12),
                  CustomElevatedButton(
                    text: Strings.loadingStateRetry,
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
