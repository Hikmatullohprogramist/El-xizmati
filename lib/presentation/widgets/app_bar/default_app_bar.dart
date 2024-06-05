import 'package:flutter/material.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';

class DefaultAppBar extends AppBar implements PreferredSizeWidget {
  final String titleText;
  final Color titleTextColor;
  @override
  final Color backgroundColor;
  final VoidCallback onBackPressed;

  DefaultAppBar({
    super.key,
    required this.titleText,
    required this.titleTextColor,
    required this.backgroundColor,
    required this.onBackPressed,
  }) : super(
          backgroundColor: backgroundColor,
          elevation: 0.5,
          centerTitle: true,
          toolbarHeight: 64,
          title: titleText.w(500).s(16).c(titleTextColor),
          leading: IconButton(
            onPressed: onBackPressed,
            icon: Assets.images.icArrowLeft.svg(),
          ),
        );
}
