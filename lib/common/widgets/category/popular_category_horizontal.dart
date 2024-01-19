import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/widgets/dashboard/app_diverder.dart';

import '../../../data/responses/category/popular_category/popular_category_response.dart';
import '../../gen/localization/strings.dart';

class PopularCategoryHorizontal extends StatelessWidget {
  const PopularCategoryHorizontal({
    super.key,
    required this.category,
    required this.onItemClicked,
  });

  final PopularCategoryResponse category;
  final Function(PopularCategoryResponse category) onItemClicked;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onItemClicked(category);
      },
      child: Container(
        width: 124,
        decoration: BoxDecoration(
          color: Color(0xFFF6F7FC),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(width: 0.90, color: Color(0xFFE5E9F3)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 8),
            Container(
              width: 52,
              height: 52,
              decoration: ShapeDecoration(shape: OvalBorder()),
              child: CachedNetworkImage(
                imageUrl:
                    "https://api.online-bozor.uz/uploads/images/${category.icon}",
                imageBuilder: (context, imageProvider) => Container(
                  decoration: _getImageDecoration(imageProvider),
                ),
                placeholder: (context, url) => Center(),
                errorWidget: (context, url, error) =>
                    Center(child: Icon(Icons.error)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: _getCategoryNameAsString(category),
            ),
            Column(
              children: [
                SizedBox(height: 4),
                AppDivider(),
                SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: _getAdsCountAsString(category),
                ),
                SizedBox(height: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Decoration _getImageDecoration(ImageProvider<Object> imageProvider) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(6),
      image: DecorationImage(
        image: imageProvider,
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(
          Color(0xFFF6F7FC),
          BlendMode.colorBurn,
        ),
      ),
    );
  }

  Widget _getCategoryNameAsString(PopularCategoryResponse category) {
    return (category.name ?? "*").w(600).s(11.5).copyWith(
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        );
  }

  Widget _getAdsCountAsString(PopularCategoryResponse category) {
    String adsCount = "";
    if (category.total != null) {
      adsCount = "${category.total?.toString()} ${Strings.categoryAdsCount}";
    }

    return adsCount.w(400).s(11).copyWith(
          textAlign: TextAlign.start,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        );
  }
}
