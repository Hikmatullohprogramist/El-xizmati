import 'package:flutter/material.dart';
import 'package:onlinebozor/presentation/support/colors/static_colors.dart';
import 'package:shimmer/shimmer.dart';

class BannerShimmer extends StatelessWidget {
  const BannerShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      margin: const EdgeInsets.only(left: 16, right: 16),
      decoration: BoxDecoration(color: Color(0xFFFFFFFF), borderRadius: BorderRadius.all(Radius.circular(16))),
      child: Padding(
        padding: const EdgeInsets.only(left: 12, top: 12, right: 12),
        child: Row(
          children: [
            Shimmer.fromColors(
              baseColor: StaticColors.shimmerBaseColor,
              highlightColor: StaticColors.shimmerHighLightColor,
              child: Container(
                width: 90,
                margin: EdgeInsets.only(left: 8, top: 8, bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Shimmer.fromColors(
                    baseColor: StaticColors.shimmerBaseColor,
                    highlightColor: StaticColors.shimmerHighLightColor,
                    child: Container(
                      height: 14,
                      margin: EdgeInsets.only(right: 32),
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
                      margin: EdgeInsets.only(right: 72),
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
                      margin: EdgeInsets.only(right: 92),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  SizedBox(height: 12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
