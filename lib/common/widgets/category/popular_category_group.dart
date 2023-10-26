import 'package:flutter/cupertino.dart';
import 'package:onlinebozor/common/widgets/category/popular_category.dart';

import '../../../data/model/categories/popular_category/popular_category_response.dart';

class PopularCategoryGroupWidget extends StatelessWidget {
  const PopularCategoryGroupWidget(
      {super.key, required this.popularCategories, this.onClick});

  final List<PopularCategoryResponse> popularCategories;
  final Function(PopularCategoryResponse result)? onClick;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 156,
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: popularCategories.length,
        padding: EdgeInsets.only(left: 16, bottom: 24, right: 16),
        itemBuilder: (context, index) {
          return AppPopularCategory(
            popularCategoryResponse: popularCategories[index],
            onClick: onClick,
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(width: 16);
        },
      ),
    );
  }
}
