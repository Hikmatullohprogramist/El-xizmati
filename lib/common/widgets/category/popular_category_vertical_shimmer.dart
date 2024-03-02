import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/assets/assets.gen.dart';
import 'package:shimmer/shimmer.dart';

import '../../../data/responses/category/popular_category/popular_category_response.dart';
import '../../gen/localization/strings.dart';

class PopularCategoryVerticalShimmer extends StatelessWidget {
  const PopularCategoryVerticalShimmer({
    super.key,

  });
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
          },
          borderRadius: BorderRadius.circular(6),
          child: Container(
            margin: EdgeInsets.symmetric(vertical:6),
            decoration: BoxDecoration(
              color: Color(0xFFF6F7FC),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(width: 0.9, color: Color(0xFFE5E9F3)),
            ),
            child: Padding(
              padding:
                  EdgeInsets.only(left: 12, top: 16, right: 16, bottom: 16),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Shimmer.fromColors(
                    baseColor: Color(0xFFE8E6E8),
                    highlightColor: Colors.grey[50]!,
                    child: Container(
                      width: 64,
                      height: 64,
                      padding: EdgeInsets.all(4),
                      decoration: ShapeDecoration(
                        shape: OvalBorder(),
                        color: Colors.white
                      ),

                    ),
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                       Shimmer.fromColors(
                         baseColor: Color(0xFFE8E6E8),
                         highlightColor: Colors.grey[50]!,
                         child: Container(
                           width: 130,height: 12,
                           decoration: BoxDecoration(
                             color: Colors.white,
                             borderRadius: BorderRadius.circular(7)
                           ),
                         ),
                       ),
                        SizedBox(height: 8),
                        Shimmer.fromColors(
                          baseColor: Color(0xFFE8E6E8),
                          highlightColor: Colors.grey[50]!,
                          child: Container(
                            width: 70,height: 12,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(7)
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8),
                  Shimmer.fromColors(
                    baseColor: Color(0xFFE8E6E8),
                    highlightColor: Colors.grey[50]!,
                    child: Container(
                      width: 28,
                      height: 28,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0x7EDFE2E9),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(width: 0.50, color: Color(0xFFE5E9F3)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

}
