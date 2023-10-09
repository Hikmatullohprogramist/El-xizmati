import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/widgets/common_button.dart';

import '../gen/localization/strings.dart';

class AppAllViewWidget extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const AppAllViewWidget(
      {super.key, required this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          title.w(600).s(16).c(context.colors.textPrimary),
          CommonButton(
            onPressed: onPressed,
            color: context.colors.buttonPrimary,
            type: ButtonType.elevated,
            child: Strings.allTitle
                .w(600)
                .s(12)
                .c(context.colors.textPrimaryInverse),
          )
        ],
      ),
    );
  }
}
