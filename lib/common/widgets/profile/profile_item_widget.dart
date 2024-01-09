import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/assets/assets.gen.dart';

class ProfileItemWidget extends StatelessWidget {
  const ProfileItemWidget(
      {super.key,
      required this.name,
      required this.icon,
      required this.invoke});

  final String name;
  final SvgGenImage icon;
  final VoidCallback invoke;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: invoke,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  icon.svg(width: 18, height: 18),
                  SizedBox(width: 16),
                  name.w(500).s(14).c(context.colors.textPrimary)
                ],
              ),
              Assets.images.icArrowRight.svg(height: 16, width: 16)
            ],
          ),
        ));
  }
}
