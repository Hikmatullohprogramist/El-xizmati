import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:El_xizmati/core/extensions/text_extensions.dart';
import 'package:El_xizmati/core/gen/localization/strings.dart';
import 'package:El_xizmati/presentation/support/extensions/color_extension.dart';

class SeeAllWidget extends StatelessWidget {
  final String title;
  final VoidCallback? onClicked;

  const SeeAllWidget({
    super.key,
    required this.title,
    this.onClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: title
                  .w(600)
                  .s(16)
                  .c(context.textPrimary)
                  .copyWith(maxLines: 1, overflow: TextOverflow.ellipsis),
            ),
          ),
          // if (onClicked != null)
            Visibility(
              visible: onClicked != null,
              child: TextButton(
                onPressed: () {
                  onClicked!();
                  HapticFeedback.lightImpact();
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Strings.allTitle.w(600).s(12).c(context.colors.textAccent),
                    SizedBox(width: 4),
                    Icon(Icons.keyboard_arrow_right_rounded),
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}
