import 'package:flutter/material.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';

class EmptyAppBar extends AppBar implements PreferredSizeWidget {
  final String titleText;
  @override
  final Color backgroundColor;

  final Color textColor;

  EmptyAppBar({
    super.key,
    this.titleText = "",
    required this.backgroundColor,
    required this.textColor,
  }) : super(
          backgroundColor: backgroundColor,
          elevation: 0.5,
          centerTitle: true,
          toolbarHeight: 64,
          leadingWidth: 0,
          leading: Assets.images.icArrowLeft.svg(color: Colors.transparent),
          title: titleText.w(500).c(textColor).s(16),
        );
}
