import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';

import '../../../data/responses/category/category/category_response.dart';
import '../../enum/enums.dart';
import '../../gen/assets/assets.gen.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
    required this.onClicked,
    required this.category,
    this.isDisableAmount = false,
    this.loadingState,
  });

  final Function(CategoryResponse category) onClicked;
  final CategoryResponse category;
  final bool isDisableAmount;
  final LoadingState? loadingState;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          onClicked(category);
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CachedNetworkImage(
                width: 20,
                height: 20,
                imageUrl:
                    "https://api.online-bozor.uz/uploads/images/${category.icon}",
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      colorFilter: ColorFilter.mode(
                        Color(0xFFF6F7FC),
                        BlendMode.colorBurn,
                      ),
                    ),
                  ),
                ),
                placeholder: (context, url) => Center(),
                errorWidget: (context, url, error) => Center(),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Row(
                  children: [
                    Flexible(
                      child: (category.name ?? "-").w(500).s(14).copyWith(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                    ),
                    if (category.hasAmount) "(${category.amount})".w(500).s(14)
                  ],
                ),
              ),
              SizedBox(width: 4),
              Assets.images.icArrowRight.svg(height: 16, width: 16)
            ],
          ),
        ),
      ),
    );
  }
}
