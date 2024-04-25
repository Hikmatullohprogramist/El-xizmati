import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/static_colors.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/assets/assets.gen.dart';

class ActionAppBar extends AppBar implements PreferredSizeWidget {
  final String titleText;
  final VoidCallback onBackPressed;
  @override
  final List<Widget>? actions;
  @override
  final Color backgroundColor;

  ActionAppBar({
    super.key,
    required this.titleText,
    this.backgroundColor = StaticColors.backgroundColor,
    required this.onBackPressed,
    this.actions,
  }) : super(
          // backgroundColor: backgroundColor,
          elevation: 0.5,
          centerTitle: true,
          toolbarHeight: 64,
          title: titleText.w(500).c(Color(0xFF41455E)).s(16),
          leading: IconButton(
            onPressed: onBackPressed,
            icon: Assets.images.icArrowLeft.svg(),
          ),
          actions: actions,
        );
}
