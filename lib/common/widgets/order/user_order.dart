import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/data/responses/user_order/user_order_response.dart';

import '../../constants.dart';
import '../../gen/assets/assets.gen.dart';
import '../common/common_button.dart';

class UserOrderWidget extends StatelessWidget {
  const UserOrderWidget({
    super.key,
    required this.listenerAddressEdit,
    required this.listener,
    required this.response,
  });

  final UserOrderResponse response;
  final VoidCallback listenerAddressEdit;
  final VoidCallback listener;

  @override
  Widget build(BuildContext context) {
    var formatter = NumberFormat('###,000');
    Widget liked(bool isLiked) {
      if (isLiked) {
        return Assets.images.icLike.svg(color: Colors.red);
      } else {
        return Assets.images.icLike.svg();
      }
    }

    return InkWell(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Container(
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(width: 0.50, color: Color(0xFFE5E9F3)),
                  color: Color(0xFFF6F7FC),
                ),
                child: CachedNetworkImage(
                  imageUrl:
                      "${Constants.baseUrlForImage}${response.products.first.main_photo}",
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              Colors.white, BlendMode.colorBurn)),
                    ),
                  ),
                  placeholder: (context, url) => Center(),
                  errorWidget: (context, url, error) =>
                      Center(child: Icon(Icons.error)),
                )),
            SizedBox(width: 12),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      "Product name".w(400).s(12).c(context.colors.textPrimary),
                      SizedBox(width: 8),
                      (response.products.first.product?.name ?? "")
                          .toString()
                          .w(500)
                          .s(12),
                    ],
                  ),
                  SizedBox(height: 3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      "Time".w(400).s(12).c(context.colors.textPrimary),
                      SizedBox(width: 8),
                      (response.created_at ?? "")
                          .toString()
                          .w(500)
                          .s(12),
                    ],
                  ),
                  SizedBox(height: 3),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     "Amount".w(400).s(12).c(context.colors.textPrimary),
                  //     SizedBox(width: 8),
                  //     (response.final_sum ?? "")
                  //         .toString()
                  //         .w(500)
                  //         .s(12),
                  //   ],
                  // ),
                  // SizedBox(height: 3),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     "Price".w(400).s(12).c(context.colors.textPrimary),
                  //     SizedBox(width: 8),
                  //     (response.products.first.product?.name ?? "")
                  //         .toString()
                  //         .w(500)
                  //         .s(12),
                  //   ],
                  // ),
                  // SizedBox(height: 3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      "Total cost".w(400).s(12).c(context.colors.textPrimary),
                      SizedBox(width: 6),
                      (response.final_sum ?? "")
                          .toString()
                          .w(500)
                          .s(12),
                    ],
                  ),
                  SizedBox(height: 6),
                  Spacer(),
                  Row(
                    children: [
                      Expanded(
                          child: CommonButton(
                              onPressed: () {},
                              child: "o'chirish"
                                  .w(500)
                                  .s(13)
                                  .c(Color(0xFFDFE2E9)))),
                      SizedBox(width: 8),
                      Expanded(
                          child: CommonButton(
                              onPressed: () {},
                              child: "Ko'proq".w(500).s(13).c(Color(0xFFDFE2E9)))),
                    ],
                  )
                ])),
          ],
        ),
      ),
      onTap: () {},
    );
  }
}
