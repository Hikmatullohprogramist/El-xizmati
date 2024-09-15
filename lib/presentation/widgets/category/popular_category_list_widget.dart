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
      height: 120,
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: categories.length,
       // padding: EdgeInsets.only(left: 16, bottom: 20, right: 16),
        itemBuilder: (context, index) {
          final category= categories[index];
          return Container(
            color: Colors.white,
            //width: 90,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                    //  border: Border.all(color: Color(0xFFBDBDBD))
                  ),
                  child: Center(
                    child:Container(
                        width: 80,
                        height: 60,
                        child: Stack(
                          children: [
                            if(category.id==1)
                              Assets.spImages.svgImages.a1.svg(),
                            if(category.id==2)
                              Assets.spImages.svgImages.a2.svg(),
                            if(category.id==3)
                              Assets.spImages.svgImages.a3.image(),
                            if(category.id==4)
                              Assets.spImages.svgImages.a4.image(),
                            if(category.id==5)
                              Assets.spImages.svgImages.a5.image(),
                            if(category.id==6)
                              Assets.spImages.svgImages.a6.image(),
                            if(category.id==7)
                              Assets.spImages.svgImages.a7.image(),
                            if(category.id==8)
                              Assets.spImages.svgImages.a8.image(),

                          ],)
                    )
                  ),
                ),
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
