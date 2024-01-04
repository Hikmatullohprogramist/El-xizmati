import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:onlinebozor/common/widgets/category/popular_category.dart';

import '../../../data/responses/category/popular_category/popular_category_response.dart';
import '../../../presentation/ad/ad_collection/cubit/ad_collection_cubit.dart';
import '../../gen/assets/assets.gen.dart';
import '../../gen/localization/strings.dart';
import '../../router/app_router.dart';
import '../dashboard/product_or_service.dart';

class PopularCategoryListWidget extends StatelessWidget {
  const PopularCategoryListWidget(
      {super.key, required this.categories, this.invoke});

  final List<PopularCategoryResponse> categories;
  final Function(PopularCategoryResponse category)? invoke;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 156,
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: categories.length + 2,
        padding: EdgeInsets.only(left: 16, bottom: 24, right: 16),
        itemBuilder: (context, index) {
          if (index == 0) {
            return ProductOrService(
              invoke: () {
                context.router.push(
                  AdCollectionRoute(collectiveType: CollectiveType.product),
                );
              },
              color: Color(0xFFB9A0FF),
              title: Strings.productsTitle,
              endColorGradient: Color(0xFFAFA2DA),
              image: Assets.images.pngImages.commondity.image(width: 100, height: 115),
              startColorGradient: Color(0xFF9570FF),
            );
          } else if (index == 1) {
            return ProductOrService(
              invoke: () {
                context.router.push(
                  AdCollectionRoute(collectiveType: CollectiveType.service),
                );
              },
              color: Color(0xFFFFBB79),
              title: Strings.servicesTitle,
              endColorGradient: Color(0xFFF0C49A),
              image: Assets.images.pngImages.service.image(width: 100, height: 108),
              startColorGradient: Color(0xFFF7993D),
            );
          } else {
            return AppPopularCategory(
              category: categories[index - 2],
              invoke: invoke,
            );
          }
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(width: 16);
        },
      ),
    );
  }
}
