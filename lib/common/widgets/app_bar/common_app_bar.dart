import 'package:flutter/material.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/assets/assets.gen.dart';

class CommonAppBar extends AppBar implements PreferredSizeWidget {
  final VoidCallback? onBackPressed;
  final String titleText;

  CommonAppBar(this.titleText, this.onBackPressed, {super.key})
      : super(
          backgroundColor: Colors.white,
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
