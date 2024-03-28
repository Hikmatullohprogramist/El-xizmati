import 'package:flutter/material.dart';
import 'package:onlinebozor/common/widgets/ad/top_rated/top_rated_ad_shimmer.dart';

class TopRatedAdListShimmer extends StatelessWidget {
  const TopRatedAdListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 144,
      color: Colors.white,
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: 6,
        padding: EdgeInsets.only(left: 16, right: 16),
        itemBuilder: (context, index) {
          return TopRatedAdWidgetShimmer();
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(width: 10);
        },
      ),
    );
  }
}
