import 'package:flutter/material.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/presentation/widgets/category/popular_category_horizontal_widget.dart';
import 'package:onlinebozor/presentation/widgets/elevation/elevation_widget.dart';

import '../../../data/datasource/network/responses/category/popular_category/popular_category_response.dart';

class PopularCategoryListWidget extends StatelessWidget {
  const PopularCategoryListWidget({
    super.key,
    required this.categories,
    required this.onCategoryClicked,
  });

  final List<PopularCategory> categories;
  final Function(PopularCategory category) onCategoryClicked;

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
          return ElevationWidget(
            topLeftRadius: 8,
            topRightRadius: 8,
            bottomLeftRadius: 8,
            bottomRightRadius: 8,
            topMargin: 1,
            bottomMargin: 1,
            child: PopularCategoryHorizontal(
              category: categories[index],
              onClicked: onCategoryClicked,
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(width: 8);
        },
      ),
    );
  }
}
