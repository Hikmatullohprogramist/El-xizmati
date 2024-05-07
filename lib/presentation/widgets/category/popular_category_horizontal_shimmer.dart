import 'package:flutter/material.dart';
import 'package:onlinebozor/core/colors/static_colors.dart';
import 'package:shimmer/shimmer.dart';

Widget PopularCategoryHorizontalShimmer() {
  return Container(
    width: 124,
    decoration: BoxDecoration(
      color: Color(0xFFF6F7FC),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(width: 0.90, color: Color(0xFFE5E9F3)),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(height: 8),
        Shimmer.fromColors(
          baseColor: StaticColors.shimmerBaseColor,
          highlightColor: StaticColors.shimmerHighLightColor,
          child: Container(
            width: 52,
            height: 52,
            decoration: ShapeDecoration(
              shape: OvalBorder(),
              color: Color(0xFFEDEEF0),
            ),
          ),
        ),
        SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Shimmer.fromColors(
            baseColor: StaticColors.shimmerBaseColor,
            highlightColor: StaticColors.shimmerHighLightColor,
            child: Container(
              height: 10,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                color: Colors.white,
              ),
            ),
          ),
        ),
        Column(
          children: [
            SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Shimmer.fromColors(
                baseColor: StaticColors.shimmerBaseColor,
                highlightColor: StaticColors.shimmerHighLightColor,
                child: Container(
                  height: 10,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 9),
          ],
        ),
      ],
    ),
  );
}
