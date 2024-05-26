import 'package:flutter/material.dart';
import 'package:onlinebozor/presentation/support/colors/static_colors.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';

class ActionAppBar extends AppBar implements PreferredSizeWidget {
  final String titleText;
  final VoidCallback onBackPressed;
  @override
  final List<Widget>? actions;
  @override
  final Color backgroundColor;
  final Color titleTextColor;

  ActionAppBar({
    super.key,
    required this.titleText,
    required this.titleTextColor,
    required this.backgroundColor,
    required this.onBackPressed,
    this.actions,
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
          actions: actions,
        );
}
