import 'package:flutter/cupertino.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';

import '../../gen/assets/assets.gen.dart';

class AdViewWidget extends StatelessWidget {
  const AdViewWidget({super.key, required this.viewCount});

  final int viewCount;

  @override
  Widget build(BuildContext context) {
    if (viewCount < 10) {
      return Container(
        width: 35,
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
            color: context.colors.iconGrey,
            border: Border.all(width: 1, color: context.colors.iconGrey),
            borderRadius: BorderRadius.circular(4)),
        child: Row(
          children: [
            Assets.images.icEye.svg(),
            SizedBox(width: 2),
            viewCount.toString().w(400).s(8).c(context.colors.textPrimary)
          ],
        ),
      );
    } else {
      if (viewCount < 100) {
        return Container(
          width: 40,
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
              color: context.colors.iconGrey,
              border: Border.all(width: 1, color: context.colors.iconGrey),
              borderRadius: BorderRadius.circular(4)),
          child: Row(
            children: [
              Assets.images.icEye.svg(),
              SizedBox(width: 2),
              viewCount.toString().w(400).s(8).c(context.colors.textPrimary)
            ],
          ),
        );
      } else {
        if (viewCount < 1000) {
          return Container(
            width: 45,
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
                color: context.colors.iconGrey,
                border: Border.all(width: 1, color: context.colors.iconGrey),
                borderRadius: BorderRadius.circular(4)),
            child: Row(
              children: [
                Assets.images.icEye.svg(),
                SizedBox(width: 2),
                viewCount.toString().w(400).s(8).c(context.colors.textPrimary)
              ],
            ),
          );
        } else {
          if (viewCount < 100000) {
            return Container(
              width: 50,
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                  color: context.colors.iconGrey,
                  border: Border.all(width: 1, color: context.colors.iconGrey),
                  borderRadius: BorderRadius.circular(4)),
              child: Row(
                children: [
                  Assets.images.icEye.svg(),
                  SizedBox(width: 2),
                  "100K".w(400).s(8).c(context.colors.textPrimary)
                ],
              ),
            );
          } else {
            return Container(
              width: 50,
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                  color: context.colors.iconGrey,
                  border: Border.all(width: 1, color: context.colors.iconGrey),
                  borderRadius: BorderRadius.circular(4)),
              child: Row(
                children: [
                  Assets.images.icEye.svg(),
                  SizedBox(width: 2),
                  "100M".w(400).s(8).c(context.colors.textPrimary)
                ],
              ),
            );
          }
        }
      }
    }
  }
}
