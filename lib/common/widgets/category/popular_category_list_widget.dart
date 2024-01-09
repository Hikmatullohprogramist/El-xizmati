import 'package:flutter/cupertino.dart';
import 'package:onlinebozor/common/widgets/category/popular_category.dart';

import '../../../data/responses/category/popular_category/popular_category_response.dart';

class PopularCategoryListWidget extends StatelessWidget {
  const PopularCategoryListWidget(
      {super.key, required this.categories, this.invoke});

  final List<PopularCategoryResponse> categories;
  final Function(PopularCategoryResponse category)? invoke;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 152,
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: categories.length,
        padding: EdgeInsets.only(left: 16, bottom: 20, right: 16),
        itemBuilder: (context, index) {
          return AppPopularCategory(
            category: categories[index],
            invoke: invoke,
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(width: 16);
        },
      ),
    );
  }
}
