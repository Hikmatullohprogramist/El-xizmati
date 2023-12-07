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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
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
