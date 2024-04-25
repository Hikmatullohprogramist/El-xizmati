import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:shimmer/shimmer.dart';

import '../../colors/static_colors.dart';

class CartShimmer extends StatelessWidget {
  const CartShimmer({
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
        children: [
          SizedBox(height: 12),
          Shimmer.fromColors(
            baseColor: StaticColors.shimmerBaseColor,
            highlightColor: StaticColors.shimmerHighLightColor,
            child: Container(
              height: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(width: 0.50, color: Color(0xFFE5E9F3)),
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Shimmer.fromColors(
                baseColor: StaticColors.shimmerBaseColor,
                highlightColor: StaticColors.shimmerHighLightColor,
                child: Container(
                  width: 120,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(width: 0.50, color: Color(0xFFE5E9F3)),
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Shimmer.fromColors(
                      baseColor: StaticColors.shimmerBaseColor,
                      highlightColor: StaticColors.shimmerHighLightColor,
                      child: Container(
                        width: 180,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Shimmer.fromColors(
                      baseColor: StaticColors.shimmerBaseColor,
                      highlightColor: StaticColors.shimmerHighLightColor,
                      child: Container(
                        width: 100,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Shimmer.fromColors(
                      baseColor: StaticColors.shimmerBaseColor,
                      highlightColor: StaticColors.shimmerHighLightColor,
                      child: Container(
                        width: 130,
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
            ],
          ),
          SizedBox(height: 12),
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
              SizedBox(width: 12),
              Flexible(
                flex: 3,
                child: Shimmer.fromColors(
                  baseColor: StaticColors.shimmerBaseColor,
                  highlightColor: StaticColors.shimmerHighLightColor,
                  child: Container(
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Flexible(
                flex: 4,
                child: Shimmer.fromColors(
                  baseColor: StaticColors.shimmerBaseColor,
                  highlightColor: StaticColors.shimmerHighLightColor,
                  child: Container(
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12)
        ],
      ),
    );
  }
}
