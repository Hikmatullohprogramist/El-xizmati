import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/data/responses/user_order/user_order_response.dart';
import 'package:shimmer/shimmer.dart';

import '../../constants.dart';
import '../button/common_button.dart';

class UserOrderWidgetShimmer extends StatelessWidget {
  const UserOrderWidgetShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: Color(0xFFE5E9F3)),
      ),
      child: InkWell(
        child: Row(
          children: [
            Shimmer.fromColors(
              baseColor: Color(0xFFE8E6E8),
              highlightColor: Colors.grey[50]!,
              child: Container(
                width: 100,
                height: 110,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(width: 0.50, color: Color(0xFFE5E9F3)),
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                  SizedBox(
                    height: 25,
                  ),
                  Shimmer.fromColors(
                    baseColor: Color(0xFFE8E6E8),
                    highlightColor: Colors.grey[50]!,
                    child: Container(
                      width: 140,
                      height: 12,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(7)),
                    ),
                  ),
                  SizedBox(height: 13),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Shimmer.fromColors(
                          baseColor: Color(0xFFE8E6E8),
                          highlightColor: Colors.grey[50]!,
                          child: Container(
                            width: 50,
                            height: 12,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: Colors.white),
                          )),
                    ],
                  ),
                  SizedBox(height: 13),
                  Shimmer.fromColors(
                    baseColor: Color(0xFFE8E6E8),
                    highlightColor: Colors.grey[50]!,
                    child: Container(
                      width: 140,
                      height: 12,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(7)),
                    ),
                  ),
                  SizedBox(height: 6),
                  Row(
                    children: [
                      Expanded(
                          child: Shimmer.fromColors(
                        baseColor: Color(0xFFE8E6E8),
                        highlightColor: Colors.grey[50]!,
                        child: CommonButton(
                            onPressed: () {},
                            child:
                                "o'chirish".w(500).s(13).c(Color(0xFFDFE2E9))),
                      )),
                      SizedBox(width: 8),
                      Expanded(
                          child: Shimmer.fromColors(
                        baseColor: Color(0xFFE8E6E8),
                        highlightColor: Colors.grey[50]!,
                        child: CommonButton(
                            onPressed: () {},
                            child: "Ko'proq".w(500).s(13).c(Color(0xFFDFE2E9))),
                      )),
                    ],
                  )
                ])),
          ],
        ),
        onTap: () {},
      ),
    );
  }
}
