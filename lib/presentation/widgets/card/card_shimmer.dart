import 'package:flutter/material.dart';
import 'package:onlinebozor/presentation/support/colors/static_colors.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:shimmer/shimmer.dart';

class CardShimmer extends StatelessWidget {
  const CardShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: context.cardStrokeColor),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 18),
          Row(
            children: [
              Shimmer.fromColors(
                baseColor: StaticColors.shimmerBaseColor,
                highlightColor: StaticColors.shimmerHighLightColor,
                child: Container(
                  width: 70,
                  height: 12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(width: 0.50, color: Color(0xFFE5E9F3)),
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 8),
              Shimmer.fromColors(
                baseColor: StaticColors.shimmerBaseColor,
                highlightColor: StaticColors.shimmerHighLightColor,
                child: Container(
                  width: 70,
                  height: 12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(width: 0.50, color: Color(0xFFE5E9F3)),
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 8),
              Shimmer.fromColors(
                baseColor: StaticColors.shimmerBaseColor,
                highlightColor: StaticColors.shimmerHighLightColor,
                child: Container(
                  width: 70,
                  height: 12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(width: 0.50, color: Color(0xFFE5E9F3)),
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          Row(
            children: [
              Shimmer.fromColors(
                baseColor: StaticColors.shimmerBaseColor,
                highlightColor: StaticColors.shimmerHighLightColor,
                child: Container(
                  width: 110,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Shimmer.fromColors(
                baseColor: StaticColors.shimmerBaseColor,
                highlightColor: StaticColors.shimmerHighLightColor,
                child: Container(
                  width: 40,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Shimmer.fromColors(
                baseColor: StaticColors.shimmerBaseColor,
                highlightColor: StaticColors.shimmerHighLightColor,
                child: Container(
                  width: 90,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Shimmer.fromColors(
                baseColor: StaticColors.shimmerBaseColor,
                highlightColor: StaticColors.shimmerHighLightColor,
                child: Container(
                  width: 110,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
              ),
              SizedBox(width: 8),
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
          SizedBox(height: 12),
          Row(
            children: [
              Shimmer.fromColors(
                baseColor: StaticColors.shimmerBaseColor,
                highlightColor: StaticColors.shimmerHighLightColor,
                child: Container(
                  width: 60,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Shimmer.fromColors(
                baseColor: StaticColors.shimmerBaseColor,
                highlightColor: StaticColors.shimmerHighLightColor,
                child: Container(
                  width: 60,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          Row(
            children: [
              Shimmer.fromColors(
                baseColor: StaticColors.shimmerBaseColor,
                highlightColor: StaticColors.shimmerHighLightColor,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Shimmer.fromColors(
                    baseColor: StaticColors.shimmerBaseColor,
                    highlightColor: StaticColors.shimmerHighLightColor,
                    child: Container(
                      width: 46,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Shimmer.fromColors(
                    baseColor: StaticColors.shimmerBaseColor,
                    highlightColor: StaticColors.shimmerHighLightColor,
                    child: Container(
                      width: 46,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Shimmer.fromColors(
                    baseColor: StaticColors.shimmerBaseColor,
                    highlightColor: StaticColors.shimmerHighLightColor,
                    child: Container(
                      width: 46,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                ],
              ),
            ],
          ),
          SizedBox(height: 18)
        ],
      ),
    );
  }
}
