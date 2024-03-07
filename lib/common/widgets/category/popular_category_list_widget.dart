import 'package:flutter/material.dart';
import 'package:onlinebozor/common/widgets/category/popular_category_horizontal.dart';
import 'package:onlinebozor/common/widgets/category/popular_category_horizontal_shimmer.dart';

import '../../../data/responses/category/popular_category/popular_category_response.dart';
import '../../enum/enums.dart';

class PopularCategoryListWidget extends StatelessWidget {
  const PopularCategoryListWidget({
    super.key,
    required this.categories,
    required this.invoke,
    required this.loadingState,
  });

  final List<PopularCategoryResponse> categories;
  final Function(PopularCategoryResponse category) invoke;
  final LoadingState loadingState;

  @override
  Widget build(BuildContext context) {
    return loadingState == LoadingState.loading
        ? _buildLoadingBody()
        : _buildSuccessBody();
  }

  Widget _buildSuccessBody() {
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
            onItemClicked: invoke,
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(width: 8);
        },
      ),
    );
  }

  Widget _buildLoadingBody() {
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
