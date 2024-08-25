import 'package:flutter/material.dart';
import 'package:El_xizmati/presentation/support/extensions/color_extension.dart';
import 'package:shimmer/shimmer.dart';

import 'package:El_xizmati/presentation/support/colors/static_colors.dart';

class CategoryShimmer extends StatelessWidget {
  const CategoryShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        color: context.cardColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Shimmer.fromColors(
              baseColor: StaticColors.shimmerBaseColor,
              highlightColor: StaticColors.shimmerHighLightColor,
              child: Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            // Assets.images.icArrowRight.svg(height: 16, width: 16),
            SizedBox(width: 16),
            Expanded(
              child: Row(
                children: [
                  Shimmer.fromColors(
                    baseColor: StaticColors.shimmerBaseColor,
                    highlightColor: StaticColors.shimmerHighLightColor,
                    child: Container(
                        width: 150,
                        height: 12,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10))),
                  )
                ],
              ),
            ),
            Shimmer.fromColors(
              baseColor: StaticColors.shimmerBaseColor,
              highlightColor: StaticColors.shimmerHighLightColor,
              child: Container(
                height: 16,
                width: 16,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
