import 'package:flutter/material.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';

class DefaultAppBar extends AppBar implements PreferredSizeWidget {
  final String titleText;
  final VoidCallback onBackPressed;
  @override
  final Color backgroundColor;

  DefaultAppBar({
    super.key,
    required this.titleText,
    required this.backgroundColor,
    required this.onBackPressed,
  }) : super(
          backgroundColor: backgroundColor,
          elevation: 0.5,
          centerTitle: true,
          toolbarHeight: 64,
          title: titleText.w(500).c(Color(0xFF41455E)).s(16),
          leading: IconButton(
            onPressed: onBackPressed,
            icon: Assets.images.icArrowLeft.svg(),
          ),
        );
}
