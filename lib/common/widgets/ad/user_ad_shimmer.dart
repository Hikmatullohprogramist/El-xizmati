import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/assets/assets.gen.dart';
import 'package:onlinebozor/common/vibrator/vibrator_extension.dart';
import 'package:onlinebozor/common/widgets/ad/list_price_text_widget.dart';
import 'package:onlinebozor/common/widgets/ad/user_ad_stats_widget.dart';
import 'package:onlinebozor/data/responses/user_ad/user_ad_response.dart';
import 'package:onlinebozor/domain/mappers/ad_enum_mapper.dart';
import 'package:shimmer/shimmer.dart';

import '../../constants.dart';

class UserAdWidgetShimmer extends StatelessWidget {
  const UserAdWidgetShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: Color(0xFFE5E9F3)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: (){},
            borderRadius: BorderRadius.circular(6),
            child: Padding(
              padding: EdgeInsets.only(left: 12, top: 12),
              child: Column(
                children: [
                  Row(
                    children: [
                      Shimmer.fromColors(
                        baseColor: Color(0xFFE8E6E8),
                        highlightColor: Colors.grey[50]!,
                        child: Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border:
                                Border.all(width: 0.50, color: Color(0xFFE5E9F3)),
                            color: Colors.deepPurple,
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Shimmer.fromColors(
                            baseColor: Color(0xFFE8E6E8),
                            highlightColor: Colors.grey[50]!,
                            child: Container(
                              height: 15,
                              margin: EdgeInsets.only(right: 50),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(7)
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Shimmer.fromColors(
                            baseColor: Color(0xFFE8E6E8),
                            highlightColor: Colors.grey[50]!,
                            child: Container(
                              height: 15,
                              margin: EdgeInsets.only(right: 15),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(7)
                              ),
                            ),
                          ),
                          SizedBox(height: 17),
                          Shimmer.fromColors(
                            baseColor: Color(0xFFE8E6E8),
                            highlightColor: Colors.grey[50]!,
                            child: Container(
                              height: 15,
                              margin: EdgeInsets.only(right: 120),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(7)
                              ),
                            ),
                          ),

                        ],
                      ))
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Shimmer.fromColors(
                        baseColor: Color(0xFFE8E6E8),
                        highlightColor: Colors.grey[50]!,
                        child: Container(
                          width: 65,
                          height: 26,
                          decoration: BoxDecoration(
                              color: Colors.white,
                            borderRadius: BorderRadius.circular(3)
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Shimmer.fromColors(
                        baseColor: Color(0xFFE8E6E8),
                        highlightColor: Colors.grey[50]!,
                        child: Container(
                          width: 65,
                          height: 26,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(3)
                          ),
                        ),
                      ),
                      SizedBox(width: 6),
                      Shimmer.fromColors(
                        baseColor: Color(0xFFE8E6E8),
                        highlightColor: Colors.grey[50]!,
                        child: Container(
                          width: 65,
                          height: 26,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(3)
                          ),
                        ),
                      ),
                      SizedBox(width: 6),
                      Shimmer.fromColors(
                        baseColor: Color(0xFFE8E6E8),
                        highlightColor: Colors.grey[50]!,
                        child: Container(
                          width: 65,
                          height: 26,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(3)
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6)
                ],
              ),
            )),
      ),
    );
  }


}
