import 'package:flutter/material.dart';
import 'package:onlinebozor/core/enum/enums.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/domain/models/category/category.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/presentation/widgets/image/rounded_cached_network_image_widget.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
    required this.onClicked,
    required this.category,
    this.isShowCount = true,
    this.loadingState,
  });

  final Function(Category category) onClicked;
  final Category category;
  final bool isShowCount;
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
          color: context.cardColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RoundedCachedNetworkImage(
                width: 20,
                height: 20,
                imageId: category.icon ?? "",
              ),
              SizedBox(width: 16),
              Expanded(
                child: Row(
                  children: [
                    Flexible(
                      child: (category.name).w(500).s(14).copyWith(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                    ),
                    if (isShowCount && category.hasAdCount)
                      "(${category.adCount})".w(500).s(14)
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
