import 'package:flutter/material.dart';
import 'package:onlinebozor/common/widgets/category/popular_category_horizontal_shimmer.dart';

class PopularCategoryListShimmer extends StatelessWidget {
  const PopularCategoryListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 154,
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: 5,
        padding: EdgeInsets.only(left: 16, bottom: 20, right: 16),
        itemBuilder: (context, index) {
          return PopularCategoryHorizontalShimmer();
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(width: 8);
        },
      ),
    );
  }
}
