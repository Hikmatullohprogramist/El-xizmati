import 'package:El_xizmati/core/extensions/text_extensions.dart';
import 'package:El_xizmati/core/gen/assets/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:El_xizmati/data/datasource/network/responses/category/popular_category/popular_category_response.dart';
import 'package:El_xizmati/presentation/widgets/category/popular_category_horizontal_widget.dart';
import 'package:El_xizmati/presentation/widgets/elevation/elevation_widget.dart';

class PopularCategoryListWidget extends StatelessWidget {
  const PopularCategoryListWidget({
    super.key,
    required this.categories,
    required this.onCategoryClicked,
  });

  final List<PopularCategory> categories;
  final Function(PopularCategory category) onCategoryClicked;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: categories.length,
        padding: EdgeInsets.only(left: 16, bottom: 20, right: 16),
        itemBuilder: (context, index) {
          final category= categories[index];
          return Container(
            color: Colors.white,
            width: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(25),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Color(0xFFBDBDBD))
                  ),
                  child: Center(
                    child: category.id==0? Assets.spImages.svgImages.computer.image():
                    Assets.spImages.svgImages.toolBox.image(),
                  ),
                ),
                SizedBox(height: 10),
                '${category.name}'.s(13).c(Color(0xFF703EDB)).copyWith(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF703EDB), fontSize: 13)
                ),
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(width: 8);
        },
      ),
    );
  }
}
