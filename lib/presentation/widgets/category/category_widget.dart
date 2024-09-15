import 'package:El_xizmati/data/datasource/network/sp_response/category/category_response/category_response.dart';
import 'package:flutter/material.dart';
import 'package:El_xizmati/core/enum/enums.dart';
import 'package:El_xizmati/core/extensions/text_extensions.dart';
import 'package:El_xizmati/core/gen/assets/assets.gen.dart';
import 'package:El_xizmati/domain/models/category/category.dart';
import 'package:El_xizmati/presentation/support/extensions/color_extension.dart';
import 'package:El_xizmati/presentation/widgets/image/rounded_cached_network_image_widget.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
    required this.onClicked,
    required this.category,
    this.isShowCount = true,
    this.loadingState,
  });

  final Function(Results category) onClicked;
  final Results category;
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
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(25),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                 // border: Border.all(color: Color(0xFFBDBDBD))
                ),
                child: Center(
                  child: Container(
                     width: 65,
                      height: 65,
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
        ),
      ),
    );
  }
}
