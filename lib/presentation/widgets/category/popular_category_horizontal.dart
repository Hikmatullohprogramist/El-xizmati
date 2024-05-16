import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/presentation/support/colors/color_extension.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/presentation/widgets/divider/custom_diverder.dart';
import 'package:onlinebozor/presentation/widgets/image/circle_cached_network_image_widget.dart';

import '../../../data/datasource/network/responses/category/popular_category/popular_category_response.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';

class PopularCategoryHorizontal extends StatelessWidget {
  const PopularCategoryHorizontal({
    super.key,
    required this.category,
    required this.onItemClicked,
  });

  final PopularCategory category;
  final Function(PopularCategory category) onItemClicked;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onItemClicked(category),
        borderRadius: BorderRadius.circular(6),
        child: Container(
          width: 124,
          decoration: BoxDecoration(
            color: context.cardColor,
            borderRadius: BorderRadius.circular(6),
            // border: Border.all(width: 0.90, color: Color(0xFFE5E9F3)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 8),
              CircleCachedNetworkImage(
                imageId: category.icon ?? "",
                imageWidth: 52,
                imageHeight: 52,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: _getCategoryNameAsString(category),
              ),
              Column(
                children: [
                  SizedBox(height: 4),
                  CustomDivider(),
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: _getAdsCountAsString(category),
                  ),
                  SizedBox(height: 9),
                ],
              ),
            ],
          ),
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

  Widget _getCategoryNameAsString(PopularCategory category) {
    return (category.name ?? "*").w(600).s(11).copyWith(
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        );
  }

  Widget _getAdsCountAsString(PopularCategory category) {
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
