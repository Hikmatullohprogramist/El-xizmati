import 'package:flutter/material.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';

class EmptyAppBar extends AppBar implements PreferredSizeWidget {
  final String titleText;

  EmptyAppBar(this.titleText, {super.key})
      : super(
          backgroundColor: Colors.white,
          elevation: 0.0,
          centerTitle: true,
          toolbarHeight: 64,
          title: titleText.w(500).c(Color(0xFF41455E)).s(16),
        );
}
