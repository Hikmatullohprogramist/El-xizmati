import 'package:flutter/material.dart';
import 'package:onlinebozor/common/widgets/category/popular_category_horizontal.dart';

import '../../../data/responses/category/popular_category/popular_category_response.dart';
import '../../enum/enums.dart';

class PopularCategoryListWidget extends StatelessWidget {
  const PopularCategoryListWidget({
    super.key,
    required this.categories,
    required this.onCategoryClicked,
  });

  final List<PopularCategoryResponse> categories;
  final Function(PopularCategoryResponse category) onCategoryClicked;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 154,
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: categories.length,
        padding: EdgeInsets.only(left: 16, bottom: 20, right: 16),
        itemBuilder: (context, index) {
          return PopularCategoryHorizontal(
            category: categories[index],
            onItemClicked: onCategoryClicked,
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(width: 8);
        },
      ),
    );
  }
}
