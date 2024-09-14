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
        ),
      ),
    );
  }
}
