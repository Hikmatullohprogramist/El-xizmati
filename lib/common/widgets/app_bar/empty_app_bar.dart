import 'package:flutter/material.dart';

class EmptyAppBar extends AppBar implements PreferredSizeWidget {
  EmptyAppBar({super.key})
      : super(
          backgroundColor: Colors.white,
          elevation: 0.5,
          centerTitle: true,
          toolbarHeight: 64,
          title: null,
        );
}
