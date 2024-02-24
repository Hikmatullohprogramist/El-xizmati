import 'package:flutter/material.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({
    super.key,
    this.height,
    this.thickness,
    this.startIndent,
    this.endIndent,
    this.color,
  });

  final double? height;
  final double? thickness;
  final double? startIndent;
  final double? endIndent;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height,
      thickness: thickness,
      indent: startIndent ?? 0,
      endIndent: endIndent ?? 0,
      color: Color(0xFFC7C7C7),
    );
  }
}
