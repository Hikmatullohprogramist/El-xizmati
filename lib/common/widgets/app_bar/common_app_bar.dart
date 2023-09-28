import 'package:flutter/material.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';

class CommonAppBar extends AppBar implements PreferredSizeWidget {
  final VoidCallback? onBack;
  final String titleText;

  CommonAppBar(this.onBack, this.titleText, {super.key})
      : super(
            backgroundColor: Colors.white,
            leadingWidth: 24,
            elevation: 0,
            centerTitle: true,
            title: titleText.w(400).c(Colors.black),
            leading: IconButton(
                onPressed: onBack,
                icon: Icon(
                  Icons.chevron_left,
                  color: Colors.black,
                )));
}
