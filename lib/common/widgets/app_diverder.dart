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
      height: height ?? 6,
      indent: indent ?? 0,
      endIndent: endIndent ?? 0,
      color: Color(0xFFE5E9F3),
    );
  }
}
