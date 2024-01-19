import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/assets/assets.gen.dart';

import '../../../data/responses/category/popular_category/popular_category_response.dart';
import '../../gen/localization/strings.dart';

class PopularCategoryVertical extends StatelessWidget {
  const PopularCategoryVertical({
    super.key,
    required this.category,
    required this.onItemClicked,
  });

  final PopularCategoryResponse category;
  final Function(PopularCategoryResponse category) onItemClicked;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
            onItemClicked(category);
          },
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFFF6F7FC),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(width: 0.9, color: Color(0xFFE5E9F3)),
            ),
            child: Padding(
              padding:
                  EdgeInsets.only(left: 12, top: 16, right: 16, bottom: 16),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    padding: EdgeInsets.all(4),
                    decoration: ShapeDecoration(
                      shape: OvalBorder(),
                    ),
                    child: CachedNetworkImage(
                      imageUrl:
                          "https://api.online-bozor.uz/uploads/images/${category.icon}",
                      imageBuilder: (context, imageProvider) => Container(
                          decoration: _getImageDecoration(imageProvider)),
                      placeholder: (context, url) => Center(),
                      errorWidget: (context, url, error) =>
                          Center(child: Icon(Icons.error)),
                    ),
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _getCategoryNameAsString(category),
                        SizedBox(height: 4),
                        _getAdsCountAsString(category)
                      ],
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    width: 28,
                    height: 28,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Color(0x7EDFE2E9),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(width: 0.50, color: Color(0xFFE5E9F3)),
                    ),
                    child: Assets.images.icArrowRight.svg(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
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
    return (category.name ?? "*").w(600).s(14).copyWith(
          textAlign: TextAlign.start,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        );
  }

  Widget _getAdsCountAsString(PopularCategoryResponse category) {
    String adsCount = "";
    if (category.total != null) {
      adsCount = "${category.total?.toString()} ${Strings.categoryAdsCount}";
    }

    return adsCount.w(400).s(14).copyWith(
          textAlign: TextAlign.start,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        );
  }
}
