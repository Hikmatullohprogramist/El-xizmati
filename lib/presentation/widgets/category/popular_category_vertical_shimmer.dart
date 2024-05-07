import 'package:flutter/material.dart';
import 'package:onlinebozor/presentation/support/colors/static_colors.dart';
import 'package:shimmer/shimmer.dart';

class PopularCategoryVerticalShimmer extends StatelessWidget {
  const PopularCategoryVerticalShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(6),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              color: Color(0xFFF6F7FC),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(width: 0.9, color: Color(0xFFE5E9F3)),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                left: 12,
                top: 16,
                right: 16,
                bottom: 16,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Shimmer.fromColors(
                    baseColor: StaticColors.shimmerBaseColor,
                    highlightColor: StaticColors.shimmerHighLightColor,
                    child: Container(
                      width: 64,
                      height: 64,
                      padding: EdgeInsets.all(4),
                      decoration: ShapeDecoration(
                        shape: OvalBorder(),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Shimmer.fromColors(
                          baseColor: StaticColors.shimmerBaseColor,
                          highlightColor: StaticColors.shimmerHighLightColor,
                          child: Container(
                            width: 150,
                            height: 12,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Shimmer.fromColors(
                          baseColor: StaticColors.shimmerBaseColor,
                          highlightColor: StaticColors.shimmerHighLightColor,
                          child: Container(
                            width: 80,
                            height: 12,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8),
                  Shimmer.fromColors(
                    baseColor: StaticColors.shimmerBaseColor,
                    highlightColor: StaticColors.shimmerHighLightColor,
                    child: Container(
                      width: 28,
                      height: 28,
                      padding: EdgeInsets.all(8),
                      decoration: ShapeDecoration(
                        shape: OvalBorder(),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
