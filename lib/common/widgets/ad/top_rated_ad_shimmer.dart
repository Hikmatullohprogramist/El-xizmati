import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../colors/static_colors.dart';

class TopRatedAdWidgetShimmer extends StatelessWidget {
  const TopRatedAdWidgetShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 248,
      padding: EdgeInsets.only(left: 12, top: 12, right: 0),
      decoration: _getBackgroundGradient(),
      child: InkWell(
        onTap: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _getAdImageWidget(),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(height: 8),
                      Shimmer.fromColors(
                        baseColor: StaticColors.shimmerBaseColor,
                        highlightColor: StaticColors.shimmerHighLightColor,
                        child: Container(
                          height: 15,
                          width: 120,
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
                          height: 15,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12),
              ],
            ),
            Shimmer.fromColors(
              baseColor: StaticColors.shimmerBaseColor,
              highlightColor: StaticColors.shimmerHighLightColor,
              child: Container(
                margin: EdgeInsets.only(left: 20),
                height: 26,
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _getAdImageWidget() {
    return SizedBox(
      width: 72,
      height: 72,
      child: Shimmer.fromColors(
        baseColor: StaticColors.shimmerBaseColor,
        highlightColor: StaticColors.shimmerHighLightColor,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Decoration _getBackgroundGradient() {
    return ShapeDecoration(
      gradient: LinearGradient(
        begin: Alignment(0, -1),
        end: Alignment(1, 1),
        colors: const [Color(0xFF9570FF), Color(0xFFF0C49A)],
      ),
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 0.50, color: Color(0xFFB9A0FF)),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
