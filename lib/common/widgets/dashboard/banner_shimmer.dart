import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../colors/static_colors.dart';

class BannerShimmer extends StatelessWidget {
  const BannerShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      decoration: BoxDecoration(color: Color(0xFFFFFFFF)),
      child: Padding(
        padding: EdgeInsets.only(left: 12, top: 12, right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Shimmer.fromColors(
              baseColor: StaticColors.shimmerBaseColor,
              highlightColor: StaticColors.shimmerHighLightColor,
              child: Container(
                height: 14,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 16),
            Shimmer.fromColors(
              baseColor: StaticColors.shimmerBaseColor,
              highlightColor: StaticColors.shimmerHighLightColor,
              child: Container(
                height: 14,
                margin: EdgeInsets.only(right: 120),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 16),
            Shimmer.fromColors(
              baseColor: StaticColors.shimmerBaseColor,
              highlightColor: StaticColors.shimmerHighLightColor,
              child: Container(
                height: 14,
                margin: EdgeInsets.only(right: 180),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
            SizedBox(height: 12),
            Shimmer.fromColors(
              baseColor: StaticColors.shimmerBaseColor,
              highlightColor: StaticColors.shimmerHighLightColor,
              child: Container(
                height: 14,
                margin: EdgeInsets.only(right: 80),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
