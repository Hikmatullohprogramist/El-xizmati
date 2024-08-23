import 'package:flutter/material.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';

class LabelTextField extends StatelessWidget {
  const LabelTextField(
    this.text, {
    super.key,
    this.isRequired = true,
  });

  final String text;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: text.w(700).s(12).copyWith(
                textAlign: TextAlign.left,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
        ),
        SizedBox(width: 8),
        Visibility(
          visible: isRequired,
          child: Assets.images.icRequiredField.svg(),
        )
      ],
    );
  }
}
