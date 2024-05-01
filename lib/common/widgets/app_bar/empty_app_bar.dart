import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/static_colors.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';

class EmptyAppBar extends AppBar implements PreferredSizeWidget {
  final String titleText;
  @override
  final Color backgroundColor;

  EmptyAppBar({
    super.key,
    this.titleText = "",
    this.backgroundColor = StaticColors.backgroundColor,
  }) : super(
          backgroundColor: backgroundColor,
          elevation: 0.0,
          centerTitle: true,
          toolbarHeight: 64,
          title: titleText.w(500)
              // .c(Color(0xFF41455E))
              .s(16),
        );
}
