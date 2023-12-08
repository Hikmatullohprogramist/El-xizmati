import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';

import '../../../data/responses/category/category/category_response.dart';
import '../../gen/assets/assets.gen.dart';

class AppCategoryWidget extends StatelessWidget {
  const AppCategoryWidget({
    super.key,
    required this.invoke,
    required this.category,
  });

  final Function(CategoryResponse category) invoke;
  final CategoryResponse category;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          invoke(category);
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CachedNetworkImage(
                width: 16,
                imageUrl:
                    'https://api.online-bozor.uz/uploads/images/8a818006fe30134f570fc587',
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: imageProvider,
                        colorFilter: ColorFilter.mode(
                            Colors.black, BlendMode.colorBurn)),
                  ),
                ),
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    Center(child: Icon(Icons.error)),
              ),
              // Assets.images.icArrowRight.svg(height: 16, width: 16),
              SizedBox(width: 16),
              Expanded(
                  child: category.name
                      .toString()
                      .w(500)
                      .s(14)
                      .c(context.colors.textPrimary)
                      .copyWith(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )),
              Assets.images.icArrowRight.svg(height: 16, width: 16)
            ],
          ),
        ));
  }
}
