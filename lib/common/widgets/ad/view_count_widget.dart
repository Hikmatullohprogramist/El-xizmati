import 'package:flutter/cupertino.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';

import '../../gen/assets/assets.gen.dart';

class ViewCountWidget extends StatelessWidget {
  const ViewCountWidget({super.key, required this.viewCount});

  final int viewCount;

  @override
  Widget build(BuildContext context) {
    if (viewCount < 10) {
      return Container(
        width: 35,
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
        decoration: BoxDecoration(
            color: context.colors.onPrimary,
            borderRadius: BorderRadius.circular(4)),
        child: Row(
          children: [
            Assets.images.icEye.svg(),
            SizedBox(width: 2),
            viewCount.toString().w(400).s(12).c(context.colors.textPrimary)
          ],
        ),
      );
    } else {
      if (viewCount < 100) {
        return Container(
          width: 42,
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
          decoration: BoxDecoration(
              color: context.colors.onPrimary,
              borderRadius: BorderRadius.circular(4)),
          child: Row(
            children: [
              Assets.images.icEye.svg(),
              SizedBox(width: 2),
              viewCount.toString().w(400).s(12).c(context.colors.textPrimary)
            ],
          ),
        );
      } else {
        if (viewCount < 1000) {
          return Container(
            width: 52,
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
            decoration: BoxDecoration(
                color: context.colors.onPrimary,
                borderRadius: BorderRadius.circular(4)),
            child: Row(
              children: [
                Assets.images.icEye.svg(),
                SizedBox(width: 4),
                viewCount.toString().w(400).s(12).c(context.colors.textPrimary)
              ],
            ),
          );
        } else {
          if (viewCount < 10000) {
            int kCount = viewCount ~/ 1000;
            return Container(
              width: 44,
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
              decoration: BoxDecoration(
                  color: context.colors.onPrimary,
                  borderRadius: BorderRadius.circular(4)),
              child: Row(
                children: [
                  Assets.images.icEye.svg(),
                  SizedBox(width: 2),
                  "${kCount}K".w(400).s(12).c(context.colors.textPrimary)
                ],
              ),
            );
          } else {
            if (viewCount < 100000) {
              int kCount = viewCount ~/ 1000;
              return Container(
                width: 52,
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                decoration: BoxDecoration(
                    color: context.colors.onPrimary,
                    borderRadius: BorderRadius.circular(4)),
                child: Row(
                  children: [
                    Assets.images.icEye.svg(),
                    SizedBox(width: 2),
                    "${kCount}K".w(400).s(12).c(context.colors.textPrimary)
                  ],
                ),
              );
            } else {
              if (viewCount < 1000000) {
                int kCount = viewCount ~/ 1000;
                return Container(
                  width: 60,
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                  decoration: BoxDecoration(
                      color: context.colors.onPrimary,
                      borderRadius: BorderRadius.circular(4)),
                  child: Row(
                    children: [
                      Assets.images.icEye.svg(),
                      SizedBox(width: 2),
                      "${kCount}K".w(400).s(12).c(context.colors.textPrimary)
                    ],
                  ),
                );
              } else {
                int mCount = viewCount ~/ 1000000;
                return Container(
                  width: 52,
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                  decoration: BoxDecoration(
                      color: context.colors.onPrimary,
                      borderRadius: BorderRadius.circular(4)),
                  child: Row(
                    children: [
                      Assets.images.icEye.svg(),
                      SizedBox(width: 2),
                      "${mCount}M".w(400).s(12).c(context.colors.textPrimary)
                    ],
                  ),
                );
              }
            }
          }
        }
      }
    }
  }
}
