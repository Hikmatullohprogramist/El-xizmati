import 'package:flutter/material.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';

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
          elevation: 0.0,
          centerTitle: true,
          toolbarHeight: 64,
          title: titleText.w(500).c(textColor).s(16),
        );
}
