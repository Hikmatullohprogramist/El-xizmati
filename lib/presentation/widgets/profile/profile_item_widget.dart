import 'package:flutter/material.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';

class ProfileItemWidget extends StatelessWidget {
  const ProfileItemWidget({
    super.key,
    required this.name,
    required this.icon,
    required this.onClicked,
    this.color,
  });

  final String name;
  final SvgGenImage icon;
  final VoidCallback onClicked;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
          onTap: () => onClicked(),
          child: Container(
            color: context.cardColor,
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    icon.svg(width: 18, height: 18),
                    SizedBox(width: 16),
                    name.w(500).s(14).c(color ?? context.textPrimary)
                  ],
                ),
                Assets.images.icArrowRight.svg(
                  height: 16,
                  width: 16,
                  color: color,
                )
              ],
            ),
          )),
    );
  }
}
