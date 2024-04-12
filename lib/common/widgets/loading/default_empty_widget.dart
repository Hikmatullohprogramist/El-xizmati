import 'package:flutter/cupertino.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';

import '../../gen/localization/strings.dart';
import '../button/custom_elevated_button.dart';

class DefaultEmptyWidget extends StatelessWidget {
  const DefaultEmptyWidget({
    super.key,
    required this.isFullScreen,
    this.message,
    this.onReloadClicked,
  });

  final bool isFullScreen;
  final String? message;
  final VoidCallback? onReloadClicked;

  @override
  Widget build(BuildContext context) {
    List<Widget> getBodyItems() {
      return [
        (message ?? Strings.loadingStateNoItemFound)
            .w(400)
            .s(14)
            .c(context.colors.textPrimary),
        SizedBox(height: 12),
        if (onReloadClicked != null)
          CustomElevatedButton(
            text: Strings.loadingStateRetry,
            buttonWidth: 180,
            onPressed: () {
              if (onReloadClicked != null) onReloadClicked!();
            },
          )
      ];
    }

    return isFullScreen
        ? Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: getBodyItems(),
            ),
          )
        : Center(
            child: SizedBox(
              height: 160,
              child: Column(
                children: getBodyItems(),
              ),
            ),
          );
  }
}
