import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import '../../../domain/model/categories/popular_category/popular_category_response.dart';

class AppPopularCategory extends StatelessWidget {
  const AppPopularCategory({
    super.key,
    required this.popularCategoryResponse,
    this.onClick,
  });

  final PopularCategoryResponse popularCategoryResponse;
  final Function(PopularCategoryResponse result)? onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onClick!(popularCategoryResponse);
      },
      child: Container(
        width: 129,
        height: 142,
        decoration: BoxDecoration(
          color: Color(0xFFF6F7FC),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(width: 0.50, color: Color(0xFFE5E9F3)),
        ),
        child: Column(
          children: [
            Container(
              width: 72,
              height: 72,
              margin: EdgeInsets.symmetric(horizontal: 28, vertical: 11),
              decoration: ShapeDecoration(
                shape: OvalBorder(),
              ),
              child: CachedNetworkImage(
                imageUrl:
                    "https://api.online-bozor.uz/uploads/images/${popularCategoryResponse.icon}",
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            Color(0xFFF6F7FC), BlendMode.colorBurn)),
                  ),
                ),
                placeholder: (context, url) =>
                    Center(),
                errorWidget: (context, url, error) =>
                    Center(child: Icon(Icons.error)),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  color: Color(0x28AEB2CD),
                  borderRadius: BorderRadius.circular(6)),
              child: Center(
                  child: (popularCategoryResponse.key_word ?? "")
                      .w(400)
                      .s(12)
                      .copyWith(
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )),
            )
          ],
        ),
      ),
    );
  }
}
