import 'package:flutter/material.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';

import '../../gen/assets/assets.gen.dart';

class LabelTextField extends StatelessWidget {
  const LabelTextField({
    super.key,
    required this.text,
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
        text.w(500).s(14).copyWith(textAlign: TextAlign.left),
        SizedBox(width: 8),
        Visibility(
          visible: isRequired,
          child: Assets.images.icRequiredField.svg(),
        )
      ],
    );
  }
}
