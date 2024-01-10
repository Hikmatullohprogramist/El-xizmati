import 'package:flutter/material.dart';

class AppDivider extends StatelessWidget {
  const AppDivider(
      {super.key, this.height, this.indent, this.endIndent, this.color});

  final double? height;
  final double? indent;
  final double? endIndent;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height ?? 1,
      indent: indent ?? 0,
      endIndent: endIndent ?? 0,
      color: Color(0xFFC7C7C7),
    );
  }
}
