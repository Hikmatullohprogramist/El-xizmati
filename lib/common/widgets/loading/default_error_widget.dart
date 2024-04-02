import 'package:flutter/cupertino.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';

import '../../gen/localization/strings.dart';
import '../button/custom_elevated_button.dart';

class DefaultErrorWidget extends StatelessWidget {
  const DefaultErrorWidget({
    super.key,
    required this.isFullScreen,
    this.onErrorToAgainRequest,
  });

  final bool isFullScreen;
  final VoidCallback? onErrorToAgainRequest;

  @override
  Widget build(BuildContext context) {
    return isFullScreen
        ? Center(
      child: Column(
        children: [
          Strings.loadingStateError.w(400).s(14).c(context.colors.textPrimary),
          SizedBox(height: 12),
          CustomElevatedButton(
            text: Strings.languageSetTitle,
            onPressed: () => onErrorToAgainRequest,
            buttonWidth: 180,
          )
        ],
      ),
    )
        : Center(
      child: SizedBox(
        height: 160,
        child: Column(
          children: [
            "Xatolik yuz berdi?"
                .w(400)
                .s(14)
                .c(context.colors.textPrimary),
            SizedBox(height: 12),
            CustomElevatedButton(
              text: "Qayta urinish",
              onPressed: () => onErrorToAgainRequest,
              buttonWidth: 180,
            )
          ],
        ),
      ),
    );
  }
}