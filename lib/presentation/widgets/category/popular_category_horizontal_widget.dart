import 'package:flutter/material.dart';
import 'package:El_xizmati/core/extensions/text_extensions.dart';
import 'package:El_xizmati/core/gen/localization/strings.dart';
import 'package:El_xizmati/data/datasource/network/responses/category/popular_category/popular_category_response.dart';
import 'package:El_xizmati/presentation/widgets/divider/custom_divider.dart';
import 'package:El_xizmati/presentation/widgets/image/circle_cached_network_image_widget.dart';

class PopularCategoryHorizontal extends StatelessWidget {
  const PopularCategoryHorizontal({
    super.key,
    required this.category,
    required this.onClicked,
  });

  final PopularCategory category;
  final Function(PopularCategory category) onClicked;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onClicked(category),
        borderRadius: BorderRadius.circular(6),
        child: Container(
          width: 124,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 8),
              CircleCachedNetworkImage(
                imageId: category.icon ?? "",
                width: 52,
                height: 52,
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
